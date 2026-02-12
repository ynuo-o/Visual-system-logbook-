# Lab2  Colour and Perception
## Part 2 - Exploring Colours in Matlab
### Task 10 - Convert RGB image to Grayscale

First, we find out information about this photo file and read the image data into the array RGB and display it. 

```matlab
imfinfo('peppers.png')
RGB = imread('peppers.png');
imshow(RGB)
```

<img src="2.png" width="300"> 

We can converts RGB values to grayscale values by using the function `rgb2gray()`, whic forming a weighted sum of the R, G, and B components according to the equation `I = 0.299 * R + 0.587 * G + 0.114 * B`

```matlab
I = rgb2gray(RGB);
figure
imshow(I)
```
<img src="3.png" width="300"> 

We can display them side-by-side with `imshowpair( )` and add a title, so that it would be easier to compare two photo.
```matlab
imshowpair(RGB, I, 'montage')
title('Original colour image (left) grayscale image (right)');
```
