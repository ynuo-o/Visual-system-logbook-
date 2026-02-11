# Lab 1
### Loading and Understanding the Test Image

The provided “clown” dataset is loaded in MATLAB as an indexed colour image represented by a matrix X and an associated colormap map.  
In the workspace, X appears as a 200 × 320 double-precision matrix whose elements store colour index values rather than direct grayscale intensities.  

```matlab
load clown
imshow(X, map)
```

<img src="1.png" width="300">

Although the indexed display may appear coloured depending on the MATLAB version, converting the image using ind2gray produces a true grayscale intensity image.

```matlab
I = ind2gray(X, map);   
imshow(I)
```

  
