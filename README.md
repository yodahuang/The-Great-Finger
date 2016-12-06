# The **GREAT** Finger

### Installation guide

`conda install -c menpo opencv3=3.1.0`

### How to select skin points

Run `mouse_select_main(target, filePath, start, ending, radius, outName)` in Matlab. Here `target` is to show whether you're selecting points that are skin or not skin.

Note: Please select a **Different ** `outName` when you run the code!

Example: 

```matlab
mouse_select_main(true, 'Dataset/sample_frames/', 2, 5, 2, 'yanda.mat')
```

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

- ~~Inside Dataset there's `borders.mat`, which is the `[left, right, top, bottom]` array get from `background_substractor.py`, use this as a constraint to detect arm~~
- ~~[Read video in Matlab](https://www.mathworks.com/help/matlab/ref/videoreader.html), then analyze each frame, store the data in another `.mat`~~
- ![Cat](http://i.imgur.com/1uYroRF.gif)