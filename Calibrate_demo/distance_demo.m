
fist_ly = [447; 489];
fist_lx = [824; 717];
fist_ry = [270; 345];
fist_rx = [594; 440];

%We suppose the camera position is fixed, so the screen parameter is known.
%Don't change it if you use the pic/vedio in dataset
screen_lx = [780; 1645; 1699; 780];
screen_ly = [154; 208; 835; 850];
screen_rx = [609; 1549; 1579; 598];
screen_ry = [4; 15; 703; 705];

% These are points of the fist get from ginput
load('stereo_params.mat');
I1 = imread('C:\Users\tianmu\Desktop\442dataset\video\5s\leftframes\frame_011.png');
I2 = imread('C:\Users\tianmu\Desktop\442dataset\video\5s\rightframes\frame_011.png');
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
    plot(point2d(1),point2d(2),'r.');
    scatter(point2d(1), point2d(2), 1000, 'r'); 
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