load('Dataset/background.mat')
load('Dataset/borders.mat')
load('model.mat')

framelist = dir('Dataset/sample_frames');

% for each frame
for i=2:2
    img = imread(strcat('Dataset/sample_frames/', framelist(i+2).name));
    mask = uint8(zeros(size(img)));
    mask(borders(i,1):borders(i,2), borders(i,3):borders(i,4), :) = ones(borders(i,2)-borders(i,1)+1, borders(i,4)-borders(i,3)+1,3);
    img = img .* mask;
    figure;
    imshow(img)
    % The dtype of the images are uint8, so A-B = 0 when A < B
    % So we need to add up (A-B) + (B-A) for the diff between A&B
    bgdiff = (background - img) + (img - background);
    bgdiff = sum(bgdiff,3) > 60;
    img = img .* uint8(repmat(bgdiff,1,1,3));
    figure;
    imshow(img)
    skin_prob = SkinColorRGBGaussianDetector(model, cluster2label, img);
    figure;
    imshow(skin_prob)
end
