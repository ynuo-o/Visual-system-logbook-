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
`montage` is a visualization parameter that displays the two images side-by-side in the same figure window.

**Principle of Grayscale Conversion**

Grayscale conversion is not a simple averaging of Red, Green, and Blue channels. Instead, it is a weighted sum based on human visual perception.
* **The Formula: $I = 0.299R + 0.587G + 0.114B$**
* **Key Reason**: This formula accounts for the fact that the human eye has different sensitivities to different wavelengths. Specifically, the human eye is most sensitive to Green (hence the highest weight of 0.587) and least sensitive to Blue (the lowest weight of 0.114). By using these specific weights, the resulting grayscale image better preserves the perceived brightness (luminance) of the original color scene.










