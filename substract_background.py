import numpy as np
import cv2
 
cap = cv2.VideoCapture('Dataset/video/Yanda_1/huang.mp4')
 
fgbg = cv2.createBackgroundSubtractorMOG2(varThreshold = 64, detectShadows = False)

count = 0

while(1):

    ret, frame = cap.read()

    if not ret:
        break

    if not count%10:
        fgmask = fgbg.apply(frame)
        fgmask = cv2.medianBlur(fgmask, 5)
        cv2.imwrite('people_mask/frame{}.png'.format(count), fgmask)
        #cv2.imshow('frame',fgmask)       
        k = cv2.waitKey(30) & 0xff
        if k == 27:
            break

    count+=1

cap.release()
cv2.destroyAllWindows()