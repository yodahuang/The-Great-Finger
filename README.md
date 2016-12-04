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
### Things to do now

- Inside Dataset there's `borders.mat`, which is the `[left, right, top, bottom]` array get from `background_substractor.py`, use this as a constraint to detect arm
- [Read video in Matlab](https://www.mathworks.com/help/matlab/ref/videoreader.html), then analyze each frame, store the data in another `.mat`
- ![Cat](http://i.imgur.com/1uYroRF.gif)