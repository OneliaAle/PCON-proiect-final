import cv2
import numpy as np
import mediapipe as mp
from pythonosc import udp_client
from pythonosc import dispatcher, osc_server
import math
import threading
import sys

osc_client = udp_client.SimpleUDPClient("127.0.0.1", 7411 )
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

        
        frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
        frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))


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

            max_relative_distance1 = 0
            max_normalized_angle1 = 0
            max_relative_distance2 = 0
            max_normalized_angle2 = 0
            max_hand = None

            frame_h, frame_w = img.shape[:2]

            if results.multi_hand_landmarks: 
                for hand_landmarks in results.multi_hand_landmarks:
                    mp_draw.draw_landmarks(img, hand_landmarks, mp_hands.HAND_CONNECTIONS)

                    thumb = hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP]
                    index = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP]
                    pinky = hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP]
                    wrist = hand_landmarks.landmark[mp_hands.HandLandmark.WRIST]

                    hand_length = np.hypot(index.x - wrist.x, index.y - wrist.y)
                    distance1 = np.hypot(index.x - thumb.x, index.y - thumb.y)
                    distance2 = np.hypot(pinky.x - thumb.x, pinky.y - thumb.y)
                    relative_distance1 = distance1 / hand_length
                    relative_distance2 = distance2 / hand_length

                    dx1, dy1 = index.x - thumb.x, index.y - thumb.y
                    dx2, dy2 = pinky.x - thumb.x, pinky.y - thumb.y
                    angle1 = math.degrees(math.atan2(abs(dy1), abs(dx1)))
                    angle2 = math.degrees(math.atan2(abs(dy2), abs(dx2)))
                    normalized_angle1 = remap_angle(angle1)
                    normalized_angle2 = remap_angle(angle2)

                    if relative_distance1 > max_relative_distance1:
                        max_relative_distance1 = relative_distance1
                        max_normalized_angle1 = normalized_angle1
                        max_relative_distance2 = relative_distance2
                        max_normalized_angle2 = normalized_angle2
                        max_hand = ((thumb.x, thumb.y), (index.x, index.y), (pinky.x, pinky.y))

            if max_hand:
                remapped_distance1 = remap_distance(max_relative_distance1)
                remapped_distance2 = remap_distance(max_relative_distance2)
                
                # Override rotation values if distance is 0
                if remapped_distance1 == 0:
                    max_normalized_angle1 = 0
                if remapped_distance2 == 0:
                    max_normalized_angle2 = 0
                
                thumb_point = (int(max_hand[0][0] * frame_width), int(max_hand[0][1] * frame_height))
                index_point = (int(max_hand[1][0] * frame_width), int(max_hand[1][1] * frame_height))
                pinky_point = (int(max_hand[2][0] * frame_width), int(max_hand[2][1] * frame_height))
                cv2.line(img, thumb_point, index_point, (0, 255, 0), 2)
                cv2.line(img, thumb_point, pinky_point, (255, 0, 0), 2)

                cv2.putText(img, f'Dist1: {remapped_distance1:.2f}', (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
                cv2.putText(img, f'Angle1: {max_normalized_angle1:.2f}', (10, 70), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
                cv2.putText(img, f'Dist2: {remapped_distance2:.2f}', (10, 110), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 0, 0), 2)
                cv2.putText(img, f'Angle2: {max_normalized_angle2:.2f}', (10, 150), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 0, 0), 2)
            else:
                remapped_distance1 = 0
                remapped_distance2 = 0
                max_normalized_angle1 = 0
                max_normalized_angle2 = 0
                
                cv2.putText(img, 'No hand detected', (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2)

            # Send OSC messages (now outside the if max_hand block)
            osc_client.send_message("/hand/distance1", remapped_distance1)
            osc_client.send_message("/hand/rotation1", max_normalized_angle1)
            osc_client.send_message("/hand/distance2", remapped_distance2)
            osc_client.send_message("/hand/rotation2", max_normalized_angle2)

            print("/hand/distance1", remapped_distance1)
            print("/hand/rotation1", max_normalized_angle1)
            print("/hand/distance2", remapped_distance2)
            print("/hand/rotation2", max_normalized_angle2)


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
    print(f"Camera test pornita")
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