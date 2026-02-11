# Lab 1
### Loading and Understanding the Test Image

The provided “clown” dataset is loaded in MATLAB as an indexed colour image represented by the matrix X and the colormap map, while caption only provides descriptive metadata of the image. In the workspace, X appears as a 200 × 320 double-precision matrix whose elements store colour index values (rather than direct grayscale intensities). The variable map is an 81×3 double matrix representing the colormap.
Each row specifies an RGB colour value in the range [0,1], and the pixel values in X act as indices that reference these colours. 
display the clown image using `imshow()`

```matlab
load clown
imshow(X, map)
```

<img src="1.png" width="300"> <img src="2.png" width="300">

Although the indexed display may appear coloured depending on the MATLAB version, converting the image using `ind2gray` produces a true grayscale intensity image.

```matlab
I = ind2gray(X, map);   
imshow(I)
```
<img src="3.png" width="300">

The variable `I` is a 200 x 320 two-dimensional matrix representing the grayscale intensity (brightness)of each pixel, with values in the range [0, 1]. If we type 

```matlab
value = I(20,319)  
 ``` 
Matlab responds with the greyscale value of the image at (20,319): 
```matlab
value = 0.3425
```
The returned value `0.3425` represents the grayscale intensity of the pixel at location `(20, 319)`.  
Since grayscale intensities in MATLAB are normalised to the range `[0, 1]`, this value corresponds to a relatively dark grey tone rather than pure black (`0`) or white (`1`).


### Task 1 - Image Rotation
#### Image Rotation Using Reverse Mapping
The function `Rotate(In, Theta)` performs geometric rotation of a grayscale image about its centre using a reverse mapping strategy with nearest-neighbour interpolation.

The size of the input image is obtained to ensure that the output image `Out` is created with the same spatial dimensions, as required by the task. The image centre is computed using:
```matlab
cx = (cols + 1) / 2  
cy = (rows + 1) / 2
 ``` 
which allows rotation to occur around the true geometric centre rather than the top-left corner.

To avoid the holes and pixel overlaps produced by forward mapping, the algorithm applies the inverse rotation matrix:
```matlab
R⁻¹ = [ cos(Theta)   sin(Theta)
       -sin(Theta)   cos(Theta) ]
 ``` 

Then, for each pixel in the destination image, the corresponding source coordinate is calculated by:
1. Translating the pixel so the origin is at the image centre
2. Applying the inverse rotation
3. Translating the coordinate back to the original reference frame
Because source coordinates are generally non-integer, the nearest-neighbour rule is used:
```matlab
x_nn = round(x_s)  
y_nn = round(y_s)
 ``` 
If the mapped source pixel lies inside the image bounds, its grayscale intensity is copied to the destination pixel.
Otherwise, the destination pixel is assigned the value 0 (black), ensuring valid output for out-of-range mappings.










