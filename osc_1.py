import cv2
import numpy as np
import mediapipe as mp
from pythonosc import udp_client
from pythonosc import dispatcher, osc_server
# from spoutpy import SpoutSender  # (activati cand Spout e instalat)
import math
import threading
import sys

# OSC client (trimite date spre Max)
osc_client = udp_client.SimpleUDPClient("127.0.0.1", 7400)

# MediaPipe setup
mp_hands = mp.solutions.hands
hands = mp_hands.Hands(static_image_mode=False,
                       max_num_hands=2,
                       min_detection_confidence=0.5,
                       min_tracking_confidence=0.5)
mp_draw = mp.solutions.drawing_utils

# Variabile globale
current_camera = None
running = False
sender = None  # Spout sender (doar daca folosesti Spout)
server = None  # OSC server
shutdown_requested = False

# Opreste camera
def stop_current_stream():
    global current_camera, running, sender
    if current_camera is not None:
        running = False
        current_camera.release()
        cv2.destroyAllWindows()
    current_camera = None
    # if sender:
    #     sender.releaseSender()
    #     sender = None

# Porneste camera si incepe tracking
def start_hand_tracking(camera_index):
    global current_camera, running, sender, shutdown_requested

    stop_current_stream()
    shutdown_requested = False

    def run_camera():
        global current_camera, running, sender, shutdown_requested

        cap = cv2.VideoCapture(camera_index)
        if not cap.isOpened():
            print(f"Eroare: nu pot deschide camera {camera_index}")
            return

        current_camera = cap
        running = True

        frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
        frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

        # sender = SpoutSender()
        # sender.createSender("mediapipe_spout", frame_width, frame_height, 0)

        def remap_distance(d):
            return np.clip((d - 0.5) / 0.5, 0, 1)

        def remap_angle(a):
            return np.clip((a - 30) / 60, 0, 1)

        while running and not shutdown_requested:
            success, img = cap.read()
            if not success:
                break

            img = cv2.flip(img, 1)  # OGLINDIRE imagine orizontal
            img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
            results = hands.process(img_rgb)

            if results.multi_hand_landmarks:
                for i, hand_landmarks in enumerate(results.multi_hand_landmarks):
                    handedness = results.multi_handedness[i].classification[0].label  # 'Left' sau 'Right'
                    mp_draw.draw_landmarks(img, hand_landmarks, mp_hands.HAND_CONNECTIONS)

                    thumb = hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP]
                    index = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP]
                    pinky = hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP]
                    wrist = hand_landmarks.landmark[mp_hands.HandLandmark.WRIST]

                    hand_length = np.hypot(index.x - wrist.x, index.y - wrist.y)
                    d1 = np.hypot(index.x - thumb.x, index.y - thumb.y)
                    d2 = np.hypot(pinky.x - thumb.x, pinky.y - thumb.y)
                    rd1 = d1 / hand_length
                    rd2 = d2 / hand_length

                    dx1, dy1 = index.x - thumb.x, index.y - thumb.y
                    dx2, dy2 = pinky.x - thumb.x, pinky.y - thumb.y
                    a1 = math.degrees(math.atan2(abs(dy1), abs(dx1)))
                    a2 = math.degrees(math.atan2(abs(dy2), abs(dx2)))

                    nr1 = remap_angle(a1)
                    nr2 = remap_angle(a2)

                    rm1 = remap_distance(rd1)
                    rm2 = remap_distance(rd2)

                    prefix = "/left" if handedness == "Left" else "/right"

                    osc_client.send_message(f"{prefix}/distance1", rm1)
                    osc_client.send_message(f"{prefix}/rotation1", nr1)
                    osc_client.send_message(f"{prefix}/distance2", rm2)
                    osc_client.send_message(f"{prefix}/rotation2", nr2)

            # Pentru Spout (daca instalezi ulterior):
            # img_bgra = cv2.cvtColor(img, cv2.COLOR_BGR2BGRA)
            # sender.sendImage(img_bgra)

            # Afiseaza imaginea in fereastra OpenCV
            cv2.imshow("Hand Tracking", img)
            if cv2.waitKey(1) & 0xFF == 27:
                break

        stop_current_stream()

        if shutdown_requested:
            print("Shutdown complet. Inchidere program.")
            if server:
                server.server_close()
            sys.exit(0)

    threading.Thread(target=run_camera, daemon=True).start()

# OSC listener (primeste comenzi din Max)
def osc_start_camera(unused_addr, camera_index):
    print(f"Camera {camera_index} pornita")
    start_hand_tracking(int(camera_index))

def osc_stop_camera(unused_addr):
    print("Camera oprita")
    stop_current_stream()

# Comanda pentru oprirea completa a scriptului
def osc_shutdown(unused_addr):
    global shutdown_requested
    print("Shutdown primit. Inchidere script...")
    shutdown_requested = True
    stop_current_stream()

# Dispatcher OSC
disp = dispatcher.Dispatcher()
disp.map("/camera/start", osc_start_camera)
disp.map("/camera/stop", osc_stop_camera)
disp.map("/shutdown", osc_shutdown)

# Server OSC
server = osc_server.ThreadingOSCUDPServer(("127.0.0.1", 7400), disp)
print(f"OSC server pornit pe {server.server_address}")
server.serve_forever()