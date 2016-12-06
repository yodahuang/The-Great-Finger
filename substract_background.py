import numpy as np
import cv2
from matplotlib import pyplot as plt
import os
import scipy.io as sio

cap = cv2.VideoCapture('Dataset/video/sample.mp4')
 
fgbg = cv2.createBackgroundSubtractorMOG2(varThreshold = 64, detectShadows = False)

count = 0

borders = []

while(1):

    ret, frame = cap.read()

    if not ret:
        print('Stop')
        break

    fgmask = fgbg.apply(frame)
    # Basic smoothing
    fgmask = cv2.medianBlur(fgmask, 3)

    [h,w] = fgmask.shape
    body_points = []
    xbody = []
    ybody = []


    #Use percentile to filter out outliers
    for i in range(h):
        for w in range(w):
            if (fgmask[i,w]>0):
                xbody.append(i)
                ybody.append(w)

    thresh = 1
    if xbody and ybody:
        xbody = np.array(xbody)
        ybody = np.array(ybody)
        left = int(np.percentile(xbody, thresh))
        right = int(np.percentile(xbody, 100 - thresh))
        top = int(np.percentile(ybody, thresh))
        bottom = int(np.percentile(ybody, 100 - thresh))
        borders.append([left, right, top, bottom])
    else:
        borders.append([NaN, NaN, NaN, NaN])

    print(count)
    count+=1
cap.release()
# Save as mat
sio.savemat('borders.mat', mdict={'borders':borders})
