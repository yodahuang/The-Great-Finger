import numpy as np
import cv2
import os

mask_directory = 'Dataset/sample_frames/'
if not os.path.exists(mask_directory):
    os.makedirs(mask_directory)

cap = cv2.VideoCapture('Dataset/video/sample.mp4')
 
count = 0

while(1):

    ret, frame = cap.read()

    if not ret:
        print('Stop')
        break

    cv2.imwrite(mask_directory+'frame_'+str(count).zfill(3)+'.png', frame)

    print(count)
    count+=1

cap.release()
    