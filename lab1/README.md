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
```matlab
function [Out] = Rotate(In, Theta)
 ```

#### Step 1 - Image Size and Output Initialisation
To begin, I needed to define the environment for the rotation. This involves gathering the input dimensions and preparing a destination matrix that matches those dimensions exactly.
The dimensions of the input image are obtained using:
```matlab
[rows, cols] = size(In)
 ```
This ensures the rotated image `Out` is created with the same spatial resolution as the original image, and pixels that do not receive valid mappings are therefore displayed as black (`0`).
```matlab
Out = zeros(rows, cols);
 ```


#### Step 2 - Define rotation centre and Inverse matrix

First, we calculate the geometric center of the image to allows rotation to occur around the true geometric centre rather than the top-left corner. Since MATLAB uses 1-based indexing, the formula `(cols + 1) / 2` and `(rows + 1) / 2`  is used to precisely locate the geometric centre, ensuring the rotation is perfectly symmetrical without any spatial drift.
```matlab
cx = (cols + 1) / 2  
cy = (rows + 1) / 2
 ``` 

To avoid the holes and pixel overlaps produced by forward mapping, the algorithm applies the inverse rotation matrix:
```matlab
R⁻¹ = [ cos(Theta)   sin(Theta)
       -sin(Theta)   cos(Theta) ]
 ``` 

#### Step 3 - The Reverse Mapping Loop
For every pixel in the destination image, I calculate its "parent" location in the source image using a three-step transformation: Translate to Origin $\rightarrow$ Rotate $\rightarrow$ Translate back.

```matlab
for y_d = 1:rows
    for x_d = 1:cols

        % Shift origin to image centre
        coord_d = [x_d - cx; y_d - cy];

        % Apply inverse rotation to find source coordinate
        coord_s = R_inv * coord_d;

        % Shift back to original coordinate system
        x_s = coord_s(1) + cx;
        y_s = coord_s(2) + cy;
 ``` 

Because source coordinates are generally non-integer, the nearest-neighbour rule is used:
```matlab
x_nn = round(x_s)  
y_nn = round(y_s)
 ``` 
If the mapped source pixel lies inside the image bounds, its grayscale intensity is copied to the destination pixel.
Otherwise, the destination pixel is assigned the value 0 (black), ensuring valid output for out-of-range mappings.
```matlab        
        if x_nn >= 1 && x_nn <= cols && y_nn >= 1 && y_nn <= rows
            Out(y_d, x_d) = In(y_nn, x_nn);
        else
            Out(y_d, x_d) = 0; % paint black if outside
        end
    end
end
end
``` 

After implementing the `Rotate` function, I conducted a test to verify its performance，using a rotation angle of 30 degrees ($\pi/6$ radians). The resulting image confirms that the Rotate function operates correctly according to the task requirements
```matlab
J = Rotate(I, pi/6);  
imshow(J)             
 ``` 
<img src="4.png" width="300">

### Task 2 - Image Shearing
#### Image Shearing Using Reverse Mapping
The function `Shear(In, Xshear, Yshear)` performs geometric shearing of a grayscale image about its centre using a reverse mapping strategy with nearest-neighbour interpolation. The transformation is applied in both horizontal and vertical directions while preserving the original image dimensions.

```matlab
function [Out] = Shear(In, Xshear, Yshear)
 ``` 

#### Step 1 – Image Size and Output Initialisation
To begin, the spatial dimensions of the input image must be obtained so that the destination image can be created with identical size. This ensures that the sheared output maintains the same spatial resolution as the original image and that unmapped pixels can be displayed as black (0).
```matlab
[rows, cols] = size(In);
Out = zeros(rows, cols);
 ``` 
#### Step 2 – Define Shearing Centre and Inverse Matrix
Shearing must occur about the geometric centre of the image rather than the top-left corner. Using MATLAB’s 1-based indexing, the precise image centre is calculated as:
```matlab
cx = (cols + 1) / 2;
cy = (rows + 1) / 2;
 ``` 
To avoid holes in the destination image, reverse mapping is used. Therefore, the inverse of the shear matrix is computed:
```matlab
A = [1,      Xshear;
     Yshear, 1     ];

A_inv = inv(A);
 ```
#### Step 3 – Reverse Mapping Loop
For every pixel in the destination image, the corresponding source coordinate is calculated through a three-step transformation:

Translate to centre → Apply inverse shear → Translate back
```matlab
for y_d = 1:rows
    for x_d = 1:cols
        
        % Shift destination pixel to centre coordinates
        coord_d = [x_d - cx; 
                   y_d - cy];
        
        % Reverse map to find source coordinate (centre-relative)
        coord_s = A_inv * coord_d;
        
        % Shift back to image coordinates
        x_s = coord_s(1) + cx;
        y_s = coord_s(2) + cy;
 ```
Because mapped source coordinates are generally non-integer, nearest-neighbour interpolation is applied:
 ```matlab       
        x_sn = round(x_s);
        y_sn = round(y_s);
 ```        
If the mapped coordinate lies within the valid image bounds, the grayscale intensity is copied from the source image. Otherwise, the destination pixel is assigned the value 0 (black).
 ```matlab       
 if (x_sn >= 1) && (x_sn <= cols) && (y_sn >= 1) && (y_sn <= rows)
            Out(y_d, x_d) = In(y_sn, x_sn);
        else
            Out(y_d, x_d) = 0;
        end
        
    end
end
end
 ```       

After implementing the `Shear` function, a test was conducted using representative shear values in both directions.
The resulting image confirms that the Rotate function operates correctly according to the task requirements
 ```matlab       
S = Shear(I, 0.1, 0.5); 
imshow(S)
 ```    












