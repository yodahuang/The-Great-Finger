fist_l = [778, 443];
fist_r = [554, 305];
screen_l = [924, 402];
screen_r = [753, 257];
% These are points of the fist get from ginput
load('stereo_params.mat');
I1 = imread('arm1.png');
I2 = imread('arm2.png');
% Undistort the images
I1 = undistortImage(I1,stereoParams.CameraParameters1);
I2 = undistortImage(I2,stereoParams.CameraParameters2);
fist_point3d = triangulate(fist_l, fist_r, stereoParams);
fist_distanceInMeters = norm(fist_point3d)/1000;
screen_point3d = triangulate(screen_l, screen_r, stereoParams);
screen_distanceInMeters = norm(screen_point3d)/1000;
%Here we get distance in z axis