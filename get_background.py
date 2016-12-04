# This is made to get the background from a clip of video
import numpy as np
import cv2
from matplotlib import pyplot as plt
import os
import scipy.io as sio

cap = cv2.VideoCapture('Dataset/video/sample.mp4')
fgbg = cv2.createBackgroundSubtractorMOG2(varThreshold = 64, detectShadows = False)

count = 0
borders = []

masks = []

while(1):

    ret, frame = cap.read()

    if not ret:
        print('End')
        break
    
    if (not count%10):
        fgmask = fgbg.apply(frame)
        fgmask = cv2.medianBlur(fgmask, 3)
        
        binary_mask = fgmask.astype(bool)

        [h,w] = binary_mask.shape
        for i in range(h):
            for j in range(w):
                if binary_mask[i,j]==0:
                    binary_mask[i,j]=np.nan
        
        binary_rgb_mask = np.dstack((binary_mask, binary_mask, binary_mask))
        # Basic smoothing
        masks.append(binary_rgb_mask*frame)

    print(count)
    count+=1

cap.release()
background = np.nanmean(np.array(masks), axis=0).astype('uint8')

# Save as mat
sio.savemat('background.mat', mdict={'background':background})
