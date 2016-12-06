load('RGBy.mat')
load('model.mat')

retrain = 0;
% re-train model
if retrain == 1
    [model, cluster2label] = TrainSkinColorRGBGaussian([R, G, B], y);
end

% detection
img = imread('Dataset/sample_frames/frame_001.png');
skin_prob = SkinColorRGBGaussianDetector(model, cluster2label, img);
imshow(skin_prob)