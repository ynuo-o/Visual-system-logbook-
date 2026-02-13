# Lab3 - Intensity Transformation and Spatial Filtering

### Task 1 - Contrast enhancement with function imadjust

First we import the image and read the image data. 
```matlab
clear all
imfinfo('assets/breastXray.tif')
f = imread('assets/breastXray.tif');
imshow(f)
```
