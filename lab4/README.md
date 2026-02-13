# Lab 4 - Morphological Image Processing

### Task 1: Dilation and Erosion
#### 1. Dilation Operation
First, we explore morphological dilation and understand how different structuring elements (SEs) modify visual information


#### Method
The binary image text-broken.tif was loaded into MATLAB. Morphological dilation was applied using three different 3×3 structuring elements:
* B1 (cross-shaped SE) – expands pixels in horizontal and vertical directions
* B2 (all ones SE) – expands pixels uniformly in all directions
* Bx (diagonal cross SE) – expands pixels mainly along diagonal directions

In addition, dilation using B1 was applied twice to observe the cumulative effect of repeated dilation.
```matlab
clear all
imfinfo('assets/breastXray.tif')
f = imread('assets/breastXray.tif');
imshow(f)
```
<img src="1.png" width="300"> 
