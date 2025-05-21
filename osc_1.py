import cv2
import numpy as np
import mediapipe as mp
from pythonosc import udp_client
from pythonosc import dispatcher, osc_server
import math
import threading
import sys

osc_client = udp_client.SimpleUDPClient("127.0.0.1", 7400)
osc_client.send_message("/test", 1)

mp_hands = mp.solutions.hands
hands = mp_hands.Hands(static_image_mode=False,
                       max_num_hands=2,
                       min_detection_confidence=0.5,
                       min_tracking_confidence=0.5)
mp_draw = mp.solutions.drawing_utils

current_camera = None
running = False
server = None
shutdown_requested = False

def stop_current_stream():
    global current_camera, running
    if current_camera is not None:
        running = False
        current_camera.release()
        cv2.destroyAllWindows()
    current_camera = None

def start_hand_tracking(camera_index):
    global current_camera, running, shutdown_requested

    stop_current_stream()
    shutdown_requested = False

    def run_camera():
        global current_camera, running, shutdown_requested

        cap = cv2.VideoCapture(camera_index)
        if not cap.isOpened():
            print(f"Eroare: nu pot deschide camera {camera_index}")
            return

        current_camera = cap
        running = True

        def euclidean(a, b):
            return np.linalg.norm(np.array([a.x, a.y]) - np.array([b.x, b.y]))

        def remap_distance(val):
            return np.clip((val - 0.1) / 0.4, 0, 1)

        def remap_angle(angle):
            return np.clip((angle - 30) / 60, 0, 1)

        while running and not shutdown_requested:
            success, img = cap.read()
            if not success:
                break

            img = cv2.flip(img, 1)
            img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
            results = hands.process(img_rgb)

            frame_h, frame_w = img.shape[:2]

            if results.multi_hand_landmarks:
                print("Mana detectata ✅")
                for i, hand_landmarks in enumerate(results.multi_hand_landmarks):
                    handedness = results.multi_handedness[i].classification[0].label  # 'Left' sau 'Right'
                    mp_draw.draw_landmarks(img, hand_landmarks, mp_hands.HAND_CONNECTIONS)

                    # Landmark-uri utile
                    thumb_tip = hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP]
                    index_tip = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP]
                    pinky_tip = hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP]
                    wrist = hand_landmarks.landmark[mp_hands.HandLandmark.WRIST]

                    prefix = "/left" if handedness == "Left" else "/right"

                    # Calcule
                    distance1 = euclidean(thumb_tip, index_tip)
                    distance2 = euclidean(thumb_tip, pinky_tip)
                    dx1, dy1 = index_tip.x - thumb_tip.x, index_tip.y - thumb_tip.y
                    dx2, dy2 = pinky_tip.x - thumb_tip.x, pinky_tip.y - thumb_tip.y
                    angle1 = math.degrees(math.atan2(abs(dy1), abs(dx1)))
                    angle2 = math.degrees(math.atan2(abs(dy2), abs(dx2)))

                    # Trimitem OSC
                    osc_client.send_message(f"{prefix}/distance1", distance1)

                    print(f"{prefix}/distance1 {distance1}")

                    
                    osc_client.send_message(f"{prefix}/rotation1", angle1)
                    osc_client.send_message(f"{prefix}/distance2", distance2)
                    osc_client.send_message(f"{prefix}/rotation2", angle2)

                    # Transformă coordonatele în pixeli
                    def to_px(landmark):
                        return (int(landmark.x * img.shape[1]), int(landmark.y * img.shape[0]))

                    thumb_px = to_px(thumb_tip)
                    index_px = to_px(index_tip)
                    pinky_px = to_px(pinky_tip)

                    # Culori
                    if handedness == "Left":
                        color1 = (0, 0, 255)      # roșu (distance1)
                        color2 = (0, 255, 255)    # galben (distance2)
                        text_color1 = (0, 0, 255)
                        text_color2 = (0, 255, 255)
                    else:
                        color1 = (0, 255, 0)      # verde (distance1)
                        color2 = (255, 0, 0)      # albastru (distance2)
                        text_color1 = (0, 255, 0)
                        text_color2 = (255, 0, 0)

                    # Desenăm linii colorate
                    cv2.line(img, thumb_px, index_px, color1, 2)
                    cv2.line(img, thumb_px, pinky_px, color2, 2)

                    # Afișăm valori pe imagine
                    if handedness == "Left":
                        x_offset, y_offset = 10, 30  # colțul stânga sus
                    else:
                        x_offset, y_offset = img.shape[1] - 200, 30  # colțul dreapta sus

                    cv2.putText(img, f'D1: {distance1:.2f}', (x_offset, y_offset), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color1, 2)
                    cv2.putText(img, f'R1: {angle1:.2f}', (x_offset, y_offset + 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color1, 2)
                    cv2.putText(img, f'D2: {distance2:.2f}', (x_offset, y_offset + 60), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color2, 2)
                    cv2.putText(img, f'R2: {angle2:.2f}', (x_offset, y_offset + 90), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color2, 2)

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

def osc_start_camera(unused_addr, camera_index):
    print(f"Camera {camera_index} pornita")
    start_hand_tracking(int(camera_index))

def osc_stop_camera(unused_addr):
    print("Camera oprita")
    stop_current_stream()

def osc_shutdown(unused_addr):
    global shutdown_requested
    print("Shutdown primit. Inchidere script...")
    shutdown_requested = True
    running = False

disp = dispatcher.Dispatcher()
disp.map("/camera/start", osc_start_camera)
disp.map("/camera/stop", osc_stop_camera)
disp.map("/shutdown", osc_shutdown)

server = osc_server.ThreadingOSCUDPServer(("127.0.0.1", 7400), disp)
print(f"OSC server pornit pe {server.server_address}")
server.serve_forever()