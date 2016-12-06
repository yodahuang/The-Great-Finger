data_true = load('Dataset/SkinClassifier/0/yanda.mat');
data_false = load('Dataset/SkinClassifier/0/yanda_false.mat');
data_false_extra = load('Dataset/SkinClassifier/0/yanda_false_extra.mat');

data = cat(1, data_true.selectedPoints, data_false.selectedPoints, data_false_extra.selectedPoints);

RGB = squeeze(data(:,1,3:5));
y = data(:,1,6);

[model, cluster2label] = TrainSkinColorRGBGaussian(RGB, y);

save('yanda_model.mat', 'model', 'cluster2label');