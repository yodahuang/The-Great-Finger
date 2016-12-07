
% fist_ly = [447; 489];
% fist_lx = [824; 717];
% fist_ry = [270; 345];
% fist_rx = [594; 440];

%We suppose the camera position is fixed, so the screen parameter is known.
%Don't change it if you use the pic/video in dataset
screen_lx = [780; 1645; 1699; 780];
screen_ly = [154; 208; 835; 850];
screen_rx = [609; 1549; 1579; 598];
screen_ry = [4; 15; 703; 705];

load('stereo_params.mat');
load('armnodes.mat');
%lx1 ly1 lx2 ly2
%rx1 ry1 rx2 ry2
file_dir = 'Dataset\video\5s\';
output_dir = strcat(file_dir, 'pointOnScreen\');

leftFileList = cellstr(ls(strcat(file_dir, 'leftframes\', '*.png')));
rightFileList = cellstr(ls(strcat(file_dir, 'rightframes\', '*.png')));

assert(length(leftFileList)==length(rightFileList));

startFrame = 10;
endFrame = 20;

for i = startFrame:endFrame
    %armPts = squeeze(armnodes(i-11, :, :));
    armPts = squeeze(armnodes(i-startFrame+1, :, :));
    fist_ly = [armPts(1,1); armPts(1,3)];
    fist_lx = [armPts(1,2); armPts(1,4)];
    fist_ry = [armPts(2,1); armPts(2,3)];
    fist_rx = [armPts(2,2); armPts(2,4)];
    
   leftImageName = leftFileList{i};
   rightImageName = rightFileList{i};
   I1 = imread(strcat(file_dir, 'leftframes\', leftImageName));
   I2 = imread(strcat(file_dir, 'rightframes\', rightImageName));
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
        hold off
    else
        disp('Pointing point is out of screen');
        imshow(I1);
        point2d = stereoParams.CameraParameters1.IntrinsicMatrix' * PT;
        point2d = point2d./point2d(3);
        hold on
        plot(point2d(1),point2d(2),'o');
        hold off
    end
    saveas(gcf, strcat(output_dir, 'frame_', int2str(i), '.png'));
end

%fist_distanceInMeters = norm(fist_point3d)/1000;
%screen_point3d = triangulate(screen_l, screen_r, stereoParams);
%screen_distanceInMeters = norm(screen_point3d)/1000;
%Here we get distance in z axis