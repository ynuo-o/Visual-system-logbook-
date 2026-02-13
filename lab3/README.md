# Lab3 - Intensity Transformation and Spatial Filtering

### Task 1 - Contrast enhancement with function imadjust

First we import the image and read the image data. 
```matlab
clear all
imfinfo('assets/breastXray.tif')
f = imread('assets/breastXray.tif');
imshow(f)
```
<img src="1.png" width="300"> 
From the MATLAB workspace, we can see that the image matrix f has a dimension of 571 × 482, representing a grayscale image with 571 rows (height) and 482 columns (width). Since the data type is uint8, pixel intensities are stored as 8-bit integer values in the range 0–255.



To understand how image data is indexed and accessed: The command f(3,10) was used to read the intensity of a single pixel.
```matlab
f(3,10)  
```

The command f(3,10) was used to read the intensity of a single pixel.

The returned value was:
