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

**Explanation**: The RGB image is represented as a three-dimensional matrix of size M-by-N-by-3. The third dimension corresponds to the red, green, and blue color channels. Each pixel’s final color is determined by the intensity values across these three channels.


We can converts RGB values to grayscale values by using the function `rgb2gray()`, whic forming a weighted sum of the R, G, and B components according to the equation `I = 0.299 * R + 0.587 * G + 0.114 * B`

```matlab
I = rgb2gray(RGB);
figure
imshow(I)
```
<img src="3.png" width="300"> 

**Explanation**: The grayscale image I is represented as a two-dimensional M-by-N matrix. Instead of storing three color channels, the RGB values are converted into a single luminance value using a weighted combination of red, green, and blue intensities. This representation reduces data dimensionality and improves computational efficiency for image processing tasks.




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


### Task 11 - Splitting an RGB image into separate channels

Dimensions and data type of the variables RGB, R, G, B and I.
| Variable | Dimensions | Data Type | Description |
|----------|------------|-----------|-------------|
| **RGB** | M × N × 3 | uint8 | **3D Matrix:** Represents the image height (M), width (N), and the 3 color channels (Red, Green, Blue). |
| **R, G, B** | M × N | uint8 | **2D Matrix:** Individual color components extracted from the RGB stack. |
| **I** | M × N | uint8 | **2D Matrix:** The final grayscale image containing only luminance (intensity) values. |







