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

def fixPlot(mat):
    b,g,r = cv2.split(mat)
    return cv2.merge([r,g,b])

while(1):

    ret, frame = cap.read()
    if not ret:
        print('End')
        break
    
    if (not count%10):
        fgmask = fgbg.apply(frame)
        fgmask = cv2.medianBlur(fgmask, 3)
        
        binary_mask = fgmask.astype('float')
        [h,w] = binary_mask.shape
        for i in range(h):
            for j in range(w):
                if binary_mask[i,j]==0:
                    binary_mask[i,j]=1
                else:
                    binary_mask[i,j]=np.nan
        binary_rgb_mask = np.dstack((binary_mask, binary_mask, binary_mask))
        # Basic smoothing
        applied = binary_rgb_mask*frame
        #plottable = fixPlot(np.nan_to_num(applied).astype('uint8'))
        #plt.figure()
        #plt.imshow(plottable)
        #plt.show()
        masks.append(binary_rgb_mask*frame)

    print(count)
    count+=1

cap.release()
background = fixPlot(np.nanmean(np.array(masks), axis=0).astype('uint8'))

# Save as mat
sio.savemat('background.mat', mdict={'background':background})
