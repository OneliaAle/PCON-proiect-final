import cv2
import numpy as np
import mediapipe as mp
from pythonosc import udp_client
from pythonosc import dispatcher, osc_server
import math
import threading
import sys
import time

osc_client = udp_client.SimpleUDPClient("127.0.0.1", 7500)
#osc_client.send_message("/test", 1)

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

# afisare pe imagine:
def to_px(landmark, img):
    return (int(landmark.x * img.shape[1]), int(landmark.y * img.shape[0]))

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

        max_relative_distance1_left = 0.1
        max_normalized_angle1_left = 0
        max_relative_distance2_left = 0.1
        max_normalized_angle2_left = 0
        max_hand_left = None

        max_relative_distance1_right = 0.1
        max_normalized_angle1_right = 0
        max_relative_distance2_right = 0.1
        max_normalized_angle2_right = 0
        max_hand_right = None


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

        i = 0
        while running and not shutdown_requested:
            success, img = cap.read()
            if not success:
                break

            img = cv2.flip(img, 1)
            img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
            results = hands.process(img_rgb)

            # max_relative_distance1_left = 0
            # max_normalized_angle1_left = 0
            # max_relative_distance2_left = 0
            # max_normalized_angle2_left = 0
            # max_hand_left = None

            # max_relative_distance1_right = 0
            # max_normalized_angle1_right = 0
            # max_relative_distance2_right = 0
            # max_normalized_angle2_right = 0
            # max_hand_right = None



            frame_h, frame_w = img.shape[:2]

            # if i % 25 != 0:  # citesti landmark la fiecare 10 frame-uri
            #     continue
            # i += 1

            if results.multi_hand_landmarks: 
                # Inițializezi variabile pentru fiecare mână
                left_hand = None
                right_hand = None
                # Identifici și salvezi separat fiecare mână
                for i, hand_landmarks in enumerate(results.multi_hand_landmarks):
                    handedness = results.multi_handedness[i].classification[0].label  # 'Left' sau 'Right'
                    if handedness == "Left":
                        left_hand = hand_landmarks
                    elif handedness == "Right":
                        right_hand = hand_landmarks

                # Procesare pentru mâna stângă
                if left_hand is not None:
                    mp_draw.draw_landmarks(img, left_hand, mp_hands.HAND_CONNECTIONS)

                    thumb = left_hand.landmark[mp_hands.HandLandmark.THUMB_TIP]
                    index = left_hand.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP]
                    pinky = left_hand.landmark[mp_hands.HandLandmark.PINKY_TIP]
                    wrist = left_hand.landmark[mp_hands.HandLandmark.WRIST]

                    hand_length_left = np.hypot(index.x - wrist.x, index.y - wrist.y)
                    # Distante brute
                    distance1_left = np.hypot(index.x - thumb.x, index.y - thumb.y)
                    distance2_left = np.hypot(pinky.x - thumb.x, pinky.y - thumb.y)

                    # Distante normalizate (relative la lungimea mainii)
                    relative_distance1_left = distance1_left / hand_length_left
                    relative_distance2_left = distance2_left / hand_length_left

                    # Unghiuri brute (in grade)
                    dx1_left, dy1_left = index.x - thumb.x, index.y - thumb.y
                    dx2_left, dy2_left = pinky.x - thumb.x, pinky.y - thumb.y
                    angle1_left = math.degrees(math.atan2(abs(dy1_left), abs(dx1_left)))
                    angle2_left = math.degrees(math.atan2(abs(dy2_left), abs(dx2_left)))

                    # Unghiuri normalizate
                    normalized_angle1_left = remap_angle(angle1_left)
                    normalized_angle2_left = remap_angle(angle2_left)

                    if relative_distance2_left > max_relative_distance2_left:
                        max_relative_distance2_left = relative_distance2_left
                    if normalized_angle2_left > max_normalized_angle2_left:
                        max_normalized_angle2_left = normalized_angle2_left

                    # relative_distance2_left = relative_distance2_left / max_relative_distance2_left

                    relative_distance2_left = min(relative_distance2_left / 2, 1)
                    normalized_angle2_left = normalized_angle2_left / max_normalized_angle2_left


                    # if relative_distance1_left > max_relative_distance1_left:
                    #     max_relative_distance1_left = relative_distance1_left
                    #     max_normalized_angle1_left = normalized_angle1_left
                    #     max_relative_distance2_left = relative_distance2_left
                    #     max_normalized_angle2_left = normalized_angle2_left
                    max_hand_left = ((thumb.x, thumb.y), (index.x, index.y), (pinky.x, pinky.y))

                                # Procesare pentru mâna stângă
                if right_hand is not None:
                    mp_draw.draw_landmarks(img, right_hand, mp_hands.HAND_CONNECTIONS)

                    thumb_tip = right_hand.landmark[mp_hands.HandLandmark.THUMB_TIP]
                    index_tip = right_hand.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP]
                    pinky_tip = right_hand.landmark[mp_hands.HandLandmark.PINKY_TIP]
                    wrist_tip = right_hand.landmark[mp_hands.HandLandmark.WRIST]

                    hand_length_right = np.hypot(index_tip.x - wrist_tip.x, index_tip.y - wrist_tip.y)
                    # Distante brute
                    distance1_right = np.hypot(index_tip.x - thumb_tip.x, index_tip.y - thumb_tip.y)
                    distance2_right = np.hypot(pinky_tip.x - thumb_tip.x, pinky_tip.y - thumb_tip.y)

                    # Distante normalizate (relative la lungimea mainii)
                    relative_distance1_right = distance1_right / hand_length_right
                    relative_distance2_right = distance2_right / hand_length_right

                    # Unghiuri brute (in grade)
                    dx1_right, dy1_right = index_tip.x - thumb_tip.x, index_tip.y - thumb_tip.y
                    dx2_right, dy2_right = pinky_tip.x - thumb_tip.x, pinky_tip.y - thumb_tip.y
                    angle1_right = math.degrees(math.atan2(abs(dy1_right), abs(dx1_right)))
                    angle2_right = math.degrees(math.atan2(abs(dy2_right), abs(dx2_right)))

                    # distance1_right = euclidean(thumb_tip, index_tip)
                    # distance2_right = euclidean(thumb_tip, pinky_tip)
                    # dx1_right, dy1_right = index_tip.x - thumb_tip.x, index_tip.y - thumb_tip.y
                    # dx2_right, dy2_right = pinky_tip.x - thumb_tip.x, pinky_tip.y - thumb_tip.y
                    # angle1_right = math.degrees(math.atan2(abs(dy1_right), abs(dx1_right)))
                    # angle2_right = math.degrees(math.atan2(abs(dy2_right), abs(dx2_right)))

                    # Unghiuri normalizate
                    normalized_angle1_right = remap_angle(angle1_right)
                    normalized_angle2_right = remap_angle(angle2_right)

                    if relative_distance1_right > max_relative_distance1_right:
                        max_relative_distance1_right = relative_distance1_right
                    if normalized_angle1_right > max_normalized_angle1_right:
                        max_normalized_angle1_right = normalized_angle1_right
                    
                    # these are not normalized
                    # max_relative_distance2_right = relative_distance2_right
                    # max_normalized_angle2_right = normalized_angle2_right

                    # relative_distance1_right = relative_distance1_right / max_relative_distance1_right
                    relative_distance1_right = min(relative_distance1_right, 1)
                    normalized_angle1_right = normalized_angle1_right / max_normalized_angle1_right
                    max_hand_right = ((thumb_tip.x, thumb_tip.y), (index_tip.x, index_tip.y), (pinky_tip.x, pinky_tip.y))

            
            if max_hand_left:
                remapped_distance1 = remap_distance(max_relative_distance1_left)
                remapped_distance2 = remap_distance(max_relative_distance2_left)
                
                # Override rotation values if distance is 0
                if remapped_distance1 == 0:
                    max_normalized_angle1_left = 0
                if remapped_distance2 == 0:
                    max_normalized_angle2_left = 0

                # Trimiti valorile normalizate prin OSC
                osc_client.send_message("/left/distance1", relative_distance1_left)
                osc_client.send_message("/left/rotation1", normalized_angle1_left)
                osc_client.send_message("/left/distance2", relative_distance2_left)
                osc_client.send_message("/left/rotation2", normalized_angle2_left)



                thumb_px_left = to_px(thumb, img)
                index_px_left = to_px(index, img)
                pinky_px_left = to_px(pinky, img)

                # color1_left = (0, 0, 255)      # rosu (distance1)
                color2_left = (0, 255, 255)    # galben (distance2)
                text_color1_left = (0, 0, 255)
                text_color2_left = (0, 255, 255)

                # cv2.line(img, thumb_px_left, index_px_left, color1_left, 2)
                cv2.line(img, thumb_px_left, pinky_px_left, color2_left, 2)

                x_offset_left, y_offset_left = 10, 30  # coltul stanga sus

                # cv2.putText(img, f'Left D1: {relative_distance1_left:.2f}', (x_offset_left, y_offset_left), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color1_left, 2)
                # cv2.putText(img, f'Left A1: {normalized_angle1_left:.2f}', (x_offset_left, y_offset_left + 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color1_left, 2)
                # cv2.putText(img, f'Left D2: {relative_distance2_left:.2f}', (x_offset_left, y_offset_left + 60), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color2_left, 2)
                # cv2.putText(img, f'Left A2: {normalized_angle2_left:.2f}', (x_offset_left, y_offset_left + 90), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color2_left, 2)
                
                cv2.putText(img, f'Left D1: {relative_distance2_left:.2f}', (x_offset_left, y_offset_left), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color2_left, 2)
                cv2.putText(img, f'Left A1: {normalized_angle2_left:.2f}', (x_offset_left, y_offset_left + 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color2_left, 2)
                


            if max_hand_right:
                remapped_distance1 = remap_distance(max_relative_distance1_right)
                remapped_distance2 = remap_distance(max_relative_distance2_right)
                
                # Override rotation values if distance is 0
                if remapped_distance1 == 0:
                    max_normalized_angle1_right = 0
                if remapped_distance2 == 0:
                    max_normalized_angle2_right = 0

                # Trimiti valorile normalizate prin OSC
                osc_client.send_message("/right/distance1", relative_distance1_right)
                osc_client.send_message("/right/rotation1", normalized_angle1_right)
                osc_client.send_message("/right/distance2", relative_distance2_right)
                osc_client.send_message("/right/rotation2", normalized_angle2_right)

                # # afisare pe imagine:
                # def to_px(landmark):
                #     return (int(landmark.x * img.shape[1]), int(landmark.y * img.shape[0]))

                thumb_px_right = to_px(thumb_tip, img)
                index_px_right = to_px(index_tip, img)
                pinky_px_right = to_px(pinky_tip, img)

                color1_right = (0, 255, 0)      # verde (distance1)
                # color2_right = (255, 0, 0)      # albastru (distance2)
                text_color1_right = (0, 255, 0)
                text_color2_right = (255, 0, 0)

                cv2.line(img, thumb_px_right, index_px_right, color1_right, 2)
                # cv2.line(img, thumb_px_right, pinky_px_right, color2_right, 2)

                x_offset_right, y_offset_right = img.shape[1] - 200, 30  # colțul dreapta sus

                cv2.putText(img, f'Right D1: {relative_distance1_right:.2f}', (x_offset_right, y_offset_right), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color1_right, 2)
                cv2.putText(img, f'Right A1: {normalized_angle1_right:.2f}', (x_offset_right, y_offset_right + 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color1_right, 2)
                # cv2.putText(img, f'Right D2: {relative_distance2_right:.2f}', (x_offset_right, y_offset_right + 60), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color2_right, 2)
                # cv2.putText(img, f'Right A2: {normalized_angle2_right:.2f}', (x_offset_right, y_offset_right + 90), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color2_right, 2)
                
                print("/right/distance1", distance1_right)
                print("/right/rotation1", angle1_right)
                print("/right/distance2", distance2_right)
                print("/right/rotation2", angle2_right)


                # # Procesare pentru mâna dreaptă
                # if right_hand is not None:
                #     mp_draw.draw_landmarks(img, right_hand, mp_hands.HAND_CONNECTIONS)

                #     thumb_tip = right_hand.landmark[mp_hands.HandLandmark.THUMB_TIP]
                #     index_tip = right_hand.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP]
                #     pinky_tip = right_hand.landmark[mp_hands.HandLandmark.PINKY_TIP]
                #     wrist = right_hand.landmark[mp_hands.HandLandmark.WRIST]

                #     distance1_right = euclidean(thumb_tip, index_tip)
                #     distance2_right = euclidean(thumb_tip, pinky_tip)
                #     dx1_right, dy1_right = index_tip.x - thumb_tip.x, index_tip.y - thumb_tip.y
                #     dx2_right, dy2_right = pinky_tip.x - thumb_tip.x, pinky_tip.y - thumb_tip.y
                #     angle1_right = math.degrees(math.atan2(abs(dy1_right), abs(dx1_right)))
                #     angle2_right = math.degrees(math.atan2(abs(dy2_right), abs(dx2_right)))

                #     osc_client.send_message("/right/distance1", distance1_right)
                #     osc_client.send_message("/right/rotation1", angle1_right)
                #     osc_client.send_message("/right/distance2", distance2_right)
                #     osc_client.send_message("/right/rotation2", angle2_right)
                    
                #     print("/right/distance1", distance1_right)
                #     print("/right/rotation1", angle1_right)
                #     print("/right/distance2", distance2_right)
                #     print("/right/rotation2", angle2_right)

                #     def to_px(landmark):
                #         return (int(landmark.x * img.shape[1]), int(landmark.y * img.shape[0]))

                #     thumb_px_right = to_px(thumb_tip)
                #     index_px_right = to_px(index_tip)
                #     pinky_px_right = to_px(pinky_tip)

                #     color1_right = (0, 255, 0)      # verde (distance1)
                #     color2_right = (255, 0, 0)      # albastru (distance2)
                #     text_color1_right = (0, 255, 0)
                #     text_color2_right = (255, 0, 0)

                #     cv2.line(img, thumb_px_right, index_px_right, color1_right, 2)
                #     cv2.line(img, thumb_px_right, pinky_px_right, color2_right, 2)

                #     x_offset_right, y_offset_right = img.shape[1] - 200, 30  # colțul dreapta sus

                #     cv2.putText(img, f'Right D1: {distance1_right:.2f}', (x_offset_right, y_offset_right), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color1_right, 2)
                #     cv2.putText(img, f'Right R1: {angle1_right:.2f}', (x_offset_right, y_offset_right + 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color1_right, 2)
                #     cv2.putText(img, f'Right D2: {distance2_right:.2f}', (x_offset_right, y_offset_right + 60), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color2_right, 2)
                #     cv2.putText(img, f'Right R2: {angle2_right:.2f}', (x_offset_right, y_offset_right + 90), cv2.FONT_HERSHEY_SIMPLEX, 0.7, text_color2_right, 2)

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
    print(f"Camera pornita")
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

server = osc_server.ThreadingOSCUDPServer(("127.0.0.1", 7411), disp)
print(f"OSC server pornit pe {server.server_address}")
server.serve_forever()