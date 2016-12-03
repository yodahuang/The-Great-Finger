import numpy as np
import cv2
from matplotlib import pyplot as plt
 
cap = cv2.VideoCapture('Dataset/video/Yanda_1/huang.mp4')
 
fgbg = cv2.createBackgroundSubtractorMOG2(varThreshold = 64, detectShadows = False)

count = 0

while(1):

    ret, frame = cap.read()

    if not ret:
        break

    if not count%10:
        fgmask = fgbg.apply(frame)
        # Basic smoothing
        fgmask = cv2.medianBlur(fgmask, 3)

        [h,w] = fgmask.shape
        body_points = []

        for i in range(h):
            for w in range(w):
                if (fgmask[i,w]>0):
                    body_points.append([i,w])

        body_points = np.array(body_points)
        [x_center, y_center] = np.median(body_points, axis=0)
        print(x_center, y_center)
        [x_var, y_var] = np.sqrt(np.var(body_points, axis=0))

        multi = 3
        left = x_center - multi * x_var
        right = x_center + multi * x_var
        top = y_center - multi * y_var
        bottom = y_center + multi * y_var

        fgmask[left:right, top] = 128
        fgmask[left:right, bottom] = 128
        fgmask[left, top:bottom] = 128
        fgmask[right, top:bottom] = 128

        # if the lines above doesn't work, use below
        # for x in range(left,right):
        #     fgmask[x,top] = 128
        #     fgmask[x,bottom] = 128
        # for y in range(top,bottom):
        #     fgmask[left,y] = 128
        #     fgmask[right,y] = 128

        plt.imshow(fgmask)
        #cv2.imwrite('people_mask/frame{}.png'.format(count), fgmask)
        cv2.imshow('frame',fgmask)       
        k = cv2.waitKey(30) & 0xff
        if k == 27:
            break

    count+=1

cap.release()
cv2.destroyAllWindows()