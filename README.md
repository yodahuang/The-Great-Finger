# The **GREAT** Finger

## Disclaimer

This project clearly shows that even if you have some kind of document, it's still possible that you forgot most of the details and is unsable to reproduce the result after a year. Sad.

### Installation guide

`conda install -c menpo opencv3=3.1.0`

### How to select skin points

Run `mouse_select_main(target, filePath, start, ending, radius, outName)` in Matlab. Here `target` is to show whether you're selecting points that are skin or not skin.

Note: Please select a **Different** `outName` when you run the code!

Example: 

```matlab
mouse_select_main(true, 'Dataset/sample_frames/', 2, 5, 2, 'yanda.mat')
```

### Python preprocessing
```bash
python preprocess.py <video directory>
```

### Skin color detector
Re-Train model (not recommended):
```matlab
load('RGBy.mat')
[model, cluster2label] = TrainSkinColorRGBGaussian([R,G,B], y)
```

Use pre-trained model:
```matlab
load('model.mat')
img = imread(...)
skin_prob = SkinColorRGBGaussianDetector(model, cluster2label, img)
```

example script for the above:
skinColor_rgbhs_gmm_data0.m

### Matlab pipeline after Python preprocess
pipeline_after_py.m

### Things to do now
- ~~Inside Dataset there's `borders.mat`, which is the `[left, right, top, bottom]` array get from `background\_substractor.py`, use this as a constraint to detect arm~~
- ~~[Read video in Matlab](https://www.mathworks.com/help/matlab/ref/videoreader.html), then analyze each frame, store the data in another `.mat`~~
- Modify ```pipeline_after_py.m``` to be general
- Presentation!
- ![Cat](http://i.imgur.com/1uYroRF.gif)
