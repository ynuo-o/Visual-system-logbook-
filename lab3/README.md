# Lab3 - Intensity Transformation and Spatial Filtering

### Task 1 - Contrast enhancement with function imadjust
#### 1. Image Import and Initial Inspection
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

The returned value was 28. This means the pixel intensity is 28 and confirms that MATLAB stores grayscale values as integer intensities.

#### 2. Intensity Range Analysis
To determine if the image uses the full dynamic range, we calculated the minimum and maximum intensity values.
```matlab
[fmin, fmax] = bounds(f(:))
```
**Results**: While the maximum value reaches the limit of 255, the minimum value starts at 21. The image does not utilize the full range $[0, 255]$, particularly in the darker (lower) intensities, which may result in a lack of shadow detail.

To visualise only top half of the image, spatial slicing was applied:
```matlab
imshow(f(1:241,:))
```
<img src="2.png" width="300"> 





