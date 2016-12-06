load('Dataset/background.mat')
load('Dataset/borders.mat')
load('model.mat')

framelist = dir('Dataset/sample_frames');
background_norm = double(background) ./ repmat(sum(background, 3),1,1,3) * 300;

% for each frame
for i=100:100
    img = imread(strcat('Dataset/sample_frames/', framelist(i+2).name));
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
end
