# -*- coding: utf-8 -*-
"""
Created on Tue Dec  6 00:45:13 2016

@author: yulin
"""

import numpy as np
import cv2
import sys
import os
import scipy.io as sio
from scipy.ndimage.morphology import binary_fill_holes as fillhole

 
def preprocess(video):
    """
    Create folder ./<name>frames
    Create ./<name>background.mat
    Create ./<name>borders.mat
    """
    
    video_dir = video[:video.rfind('/') + 1]
    video_name = video[video.rfind('/') + 1: -4]
    frames_dir = video_dir + video_name + 'frames/'
    if not os.path.exists(frames_dir):
        os.makedirs(frames_dir)
    
    cap = cv2.VideoCapture(video)
    fgbg = cv2.createBackgroundSubtractorMOG2(varThreshold = 64, detectShadows = False)
    count = 0
    borders = []
    masks = []
    
    while(1):
        # Read each frame of the video
        ret, frame = cap.read()
        if not ret:
            print('Stop')
            break
        
        # Save video frames
        cv2.imwrite(frames_dir +'frame_'+str(count).zfill(3)+'.png', frame)
        
        # Apply Background Substractor to get foreground mask
        fgmask = fgbg.apply(frame)
        # Basic smoothing
        fgmask = cv2.medianBlur(fgmask, 3)
    
        # Get the borders
        [h,w] = fgmask.shape
        xbody = []
        ybody = []   
        #Use percentile to filter out outliers
        for i in range(h):
            for j in range(w):
                if (fgmask[i,j]>0):
                    xbody.append(i)
                    ybody.append(j)
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
            
        # Get the background
        if (not count%10):
            binary_mask = fgmask.astype('float')
            binary_mask = fillhole(binary_mask).astype(float)
            for i in range(h):
                for j in range(w):
                    if binary_mask[i,j]==0:
                        binary_mask[i,j]=1
                    else:
                        binary_mask[i,j]=np.nan
            binary_rgb_mask = np.dstack((binary_mask, binary_mask, binary_mask))
            applied = binary_rgb_mask*frame
            #cv2.imshow("applied",applied)
            masks.append(applied)
    
        print(count)
        count+=1
        
    cap.release()
    # Save background and borders as mat
    sio.savemat(video_dir + video_name + 'borders.mat', mdict={'borders':borders})
    background = fixPlot(np.nanmean(np.array(masks), axis=0).astype('uint8'))
    sio.savemat(video_dir + video_name + 'background.mat', mdict={'background':background})

def fixPlot(mat):
    b,g,r = cv2.split(mat)
    return cv2.merge([r,g,b])

if __name__ == '__main__':
    if len(sys.argv) != 2:
        raise Exception("Error Usage: python preprocess.py <vidio directory>")
    video_dir = sys.argv[1]
    preprocess(video_dir + 'left.mp4')
    preprocess(video_dir + 'right.mp4')
