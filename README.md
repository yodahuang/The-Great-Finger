# The **GREAT** Finger

### Installation guide

`conda install -c menpo opencv3=3.1.0`

### Skin color detector
Train model:
```matlab
load('RGBy.mat', 'R', 'G', 'B', 'y')
[model, cluster2label] = TrainSkinColorRGBGaussian(RGB, y)
```

Use pre-trained model:
```matlab
load('model.mat', 'model', 'cluster2label')
img = imread(...)
skin_prob = SkinColorRGBGaussianDetector(model, cluster2label, img)
```
