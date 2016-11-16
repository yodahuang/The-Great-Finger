import numpy as np
import cv2
 
cap = cv2.VideoCapture('test.mp4')
 
fgbg = cv2.createBackgroundSubtractorMOG2(varThreshold = 64, detectShadows = False)

count = 0

while(1):

    ret, frame = cap.read()

    if not ret:
        break

    if not count%10:
        fgmask = fgbg.apply(frame)
        cv2.imshow('frame',fgmask)       
        k = cv2.waitKey(30) & 0xff
        if k == 27:
            break

    count+=1

cap.release()
cv2.destroyAllWindows()