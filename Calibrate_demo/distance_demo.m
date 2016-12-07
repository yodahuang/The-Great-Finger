fist_lx = [774; 675];
fist_ly = [444; 486];
fist_rx = [546; 423];
fist_ry = [303; 346];
screen_lx = [780; 1648; 1704; 778];
screen_ly = [130; 174; 837; 849];
screen_rx = [609; 1554; 1579; 598];
screen_ry = [0; 1; 705; 708];
% These are points of the fist get from ginput
load('stereo_params.mat');
I1 = imread('arm1.png');
I2 = imread('arm2.png');
% Undistort the images
I1 = undistortImage(I1,stereoParams.CameraParameters1);
I2 = undistortImage(I2,stereoParams.CameraParameters2);
fist_point3d = triangulate([fist_lx, fist_ly], [fist_rx, fist_ry], stereoParams);
screen_point3d = triangulate([screen_lx, screen_ly], [screen_rx, screen_ry], stereoParams);
[PT, onScreen] = intersectPT(fist_point3d, screen_point3d);
if(onScreen == 1)
    imshow(I1);
    point2d = stereoParams.CameraParameters1.IntrinsicMatrix' * PT;
    point2d = point2d./point2d(3);
    hold on
    plot(point2d(1),point2d(2),'*');
else
    disp('Pointing point is out of screen');
    imshow(I1);
    point2d = stereoParams.CameraParameters1.IntrinsicMatrix' * PT;
    point2d = point2d./point2d(3);
    hold on
    plot(point2d(1),point2d(2),'o');
end
%fist_distanceInMeters = norm(fist_point3d)/1000;
%screen_point3d = triangulate(screen_l, screen_r, stereoParams);
%screen_distanceInMeters = norm(screen_point3d)/1000;
%Here we get distance in z axis