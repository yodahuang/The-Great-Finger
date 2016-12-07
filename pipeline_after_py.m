load('Dataset/video/5s/leftbackground.mat')
load('Dataset/video/5s/leftborders.mat')
load('yanda_model.mat')

frame_folder = 'Dataset/video/5s/leftframes/';

framelist = dir(frame_folder);
background_norm = double(background) ./ repmat(sum(background, 3),1,1,3) * 300;

% for each frame
for i=11:11
    img = imread(strcat(frame_folder, framelist(i+2).name));
    mask = uint8(zeros(size(img)));
    mask(borders(i,1):borders(i,2), borders(i,3):borders(i,4), :) = ones(borders(i,2)-borders(i,1)+1, borders(i,4)-borders(i,3)+1,3);
    img = img .* mask;
    figure;
    imshow(img)
    img_norm = double(img) ./ repmat(sum(img, 3),1,1,3) * 300;
    bgdiff = abs(background_norm - img_norm);
    bgdiff = sum(bgdiff,3) > 20;
    img = img .* uint8(repmat(bgdiff,1,1,3));
    figure;
    imshow(img)
    skin_prob = SkinColorRGBGaussianDetector(model, cluster2label, img);
    img = img .* uint8(repmat(skin_prob,1,1,3));
    figure;
    imshow(img)
    figure;
    imshow(skin_prob>0.9)
    [row, column] = find(skin_prob>0.9);
    skin_indexs = cat(2, row, column);
    % May need to change the params
    [theta, rho] = ransac(skin_indexs', 1000, 10, 0.2);
    [h,~] = size(skin_indexs);
    points_along_the_line = [1,2];
    for i = 1:h
        if(getPointToLineDist(theta, rho, skin_indexs(i,1), skin_indexs(i,2))<10)
            points_along_the_line(end+1,:)=skin_indexs(i,:);
        end
    end
    points_along_the_line(1)=[];
end
