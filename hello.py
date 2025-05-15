

"""Small example OSC server

This program listens to several addresses, and prints some information about
received packets.
"""
"""
import argparse
import math

from pythonosc.dispatcher import Dispatcher
from pythonosc import osc_server

def print_volume_handler(unused_addr, args, volume):
  print("[{0}] ~ {1}".format(args[0], volume))

def print_compute_handler(unused_addr, args, volume):
  try:
    print("[{0}] ~ {1}".format(args[0], args[1](volume)))
  except ValueError: pass

if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("--ip",
      default="127.0.0.1", help="The ip to listen on")
  parser.add_argument("--port",
      type=int, default=5005, help="The port to listen on")
  args = parser.parse_args()

  dispatcher = Dispatcher()
  dispatcher.map("/filter", print)
  dispatcher.map("/volume", print_volume_handler, "Volume")
  dispatcher.map("/logvolume", print_compute_handler, "Log volume", math.log)

  server = osc_server.ThreadingOSCUDPServer(
      (args.ip, args.port), dispatcher)
  print("Serving on {}".format(server.server_address))
  server.serve_forever()
  
  """



# from pythonosc.udp_client import SimpleUDPClient
# import time

# # Set IP and port where Max is listening
# ip = "127.0.0.1"
# port = 7400  # You can change this but must match in Max

# # Create OSC client
# client = SimpleUDPClient(ip, port)

# # Send messages
# for i in range(5):
#   client.send_message("/hello", f"This is message #{i}")
#   print(f"Sent: This is message #{i}")
#   time.sleep(1)










"""
import cv2
import numpy as np
import mediapipe as mp
from pythonosc import udp_client
import sys
import math
import tkinter as tk
from tkinter import ttk
import threading
import time

# Initialize OSC client
osc_client = udp_client.SimpleUDPClient("127.0.0.1", 7400)

# Initialize MediaPipe Hands
mp_hands = mp.solutions.hands
hands = mp_hands.Hands(
    static_image_mode=False,
    max_num_hands=2,
    min_detection_confidence=0.5,
    min_tracking_confidence=0.5
)
mp_draw = mp.solutions.drawing_utils

# Global variables
current_camera = None
running = False
loading = False

def stop_current_stream():
    global current_camera, running
    if current_camera is not None:
        running = False
        current_camera.release()
        cv2.destroyAllWindows()
    current_camera = None

def start_hand_tracking(camera_index):
    global current_camera, running, loading
    
    stop_current_stream()
    loading = True
    update_ui_state()
    
    def initialize_camera():
        global current_camera, running, loading
        
        cap = cv2.VideoCapture(camera_index)
        if not cap.isOpened():
            print(f"Error: Could not open webcam {camera_index}.")
            loading = False
            update_ui_state()
            return

        current_camera = cap
        running = True
        loading = False
        update_ui_state()

        frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
        frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

        def remap_distance(distance):
            min_distance = 0.5
            max_distance = 1.0
            remapped = (distance - min_distance) / (max_distance - min_distance)
            return max(0, min(remapped, 1))

        def remap_angle(angle):
            deadzone = 30
            if angle < deadzone:
                return 0
            else:
                return min((angle - deadzone) / (90 - deadzone), 1)

        while running:
            success, img = cap.read()
            if not success:
                break

            img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
            results = hands.process(img_rgb)

            max_relative_distance1 = 0
            max_normalized_angle1 = 0
            max_relative_distance2 = 0
            max_normalized_angle2 = 0
            max_hand = None

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

            cv2.imshow("Hand Tracking", img)

            if cv2.waitKey(1) & 0xFF == 27:  # Press 'Esc' to exit
                break

        stop_current_stream()

    threading.Thread(target=initialize_camera, daemon=True).start()

def update_ui_state():
    if loading:
        status_label.config(text="Loading...")
        start_button.config(state=tk.DISABLED)
        camera_menu.config(state=tk.DISABLED)
    elif running:
        status_label.config(text="Running")
        start_button.config(state=tk.NORMAL)
        camera_menu.config(state=tk.NORMAL)
    else:
        status_label.config(text="Stopped")
        start_button.config(state=tk.NORMAL)
        camera_menu.config(state=tk.NORMAL)

# Create the main window
root = tk.Tk()
root.title("Camera Selection")

# Create a list of camera options
camera_options = [f"Camera {i}" for i in range(10)]  # Assuming up to 10 cameras

# Create and pack the dropdown menu
camera_var = tk.StringVar(root)
camera_var.set(camera_options[0])  # Set default value
camera_menu = ttk.Combobox(root, textvariable=camera_var, values=camera_options)
camera_menu.pack(pady=10)

# Create and pack the start button
start_button = ttk.Button(root, text="Start", command=lambda: start_hand_tracking(int(camera_var.get().split()[1])))
start_button.pack(pady=10)

# Create and pack the status label (throbber)
status_label = ttk.Label(root, text="Stopped")
status_label.pack(pady=10)


# Start the Tkinter event loop
root.mainloop()
"""


import cv2
import numpy as np
import mediapipe as mp
from pythonosc import udp_client
import sys
import math
import threading
import time

# Initialize OSC client
osc_client = udp_client.SimpleUDPClient("127.0.0.1", 7400)

# Initialize MediaPipe Hands
mp_hands = mp.solutions.hands
hands = mp_hands.Hands(
    static_image_mode=False,
    max_num_hands=2,
    min_detection_confidence=0.5,
    min_tracking_confidence=0.5
)
mp_draw = mp.solutions.drawing_utils

# Global variables
current_camera = None
running = False
loading = False

def stop_current_stream():
    global current_camera, running
    if current_camera is not None:
        running = False
        current_camera.release()
        cv2.destroyAllWindows()
    current_camera = None

def start_hand_tracking(camera_index):
    global current_camera, running, loading
    
    stop_current_stream()
    loading = True
    update_ui_state()
    
    def initialize_camera():
        global current_camera, running, loading
        
        cap = cv2.VideoCapture(camera_index)
        if not cap.isOpened():
            print(f"Error: Could not open webcam {camera_index}.")
            loading = False
            update_ui_state()
            return

        current_camera = cap
        running = True
        loading = False
        update_ui_state()

        frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
        frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

        def remap_distance(distance):
            min_distance = 0.5
            max_distance = 1.0
            remapped = (distance - min_distance) / (max_distance - min_distance)
            return max(0, min(remapped, 1))

        def remap_angle(angle):
            deadzone = 30
            if angle < deadzone:
                return 0
            else:
                return min((angle - deadzone) / (90 - deadzone), 1)

        while running:
            success, img = cap.read()
            if not success:
                break

            img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
            results = hands.process(img_rgb)

            max_relative_distance1 = 0
            max_normalized_angle1 = 0
            max_relative_distance2 = 0
            max_normalized_angle2 = 0
            max_hand = None

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

            cv2.imshow("Hand Tracking", img)

            if cv2.waitKey(1) & 0xFF == 27:  # Press 'Esc' to exit
                break

        stop_current_stream()

    threading.Thread(target=initialize_camera, daemon=True).start()

def update_ui_state():
    if loading:
        status_label.config(text="Loading...")
        start_button.config(state=tk.DISABLED)
        camera_menu.config(state=tk.DISABLED)
    elif running:
        status_label.config(text="Running")
        start_button.config(state=tk.NORMAL)
        camera_menu.config(state=tk.NORMAL)
    else:
        status_label.config(text="Stopped")
        start_button.config(state=tk.NORMAL)
        camera_menu.config(state=tk.NORMAL)



# Listener OSC pentru control direct din Max
from pythonosc import dispatcher, osc_server

def osc_start_camera(unused_addr, camera_index):
    print(f"Starting camera {camera_index}")
    start_hand_tracking(int(camera_index))

def osc_stop_camera(unused_addr):
    print("Stopping camera")
    stop_current_stream()

# Configurează dispatcher-ul OSC
disp = dispatcher.Dispatcher()
disp.map("/camera/start", osc_start_camera)
disp.map("/camera/stop", osc_stop_camera)

server = osc_server.ThreadingOSCUDPServer(("127.0.0.1", 7400), disp)
print(f"Serving OSC on {server.server_address}")

server.serve_forever()