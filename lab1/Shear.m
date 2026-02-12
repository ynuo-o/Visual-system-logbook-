function [Out] = Shear(In, Xshear, Yshear)

% Get image size
[rows, cols] = size(In);

% Create output image filled with zeros (black)
Out = zeros(rows, cols);

% Compute image centre (pixel-centre convention)
cx = (cols + 1) / 2;
cy = (rows + 1) / 2;

% shear matrix
A = [1,      Xshear;
     Yshear, 1     ];

A_inv = inv(A);

% Loop over every pixel in destination image
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
        
        % Nearest neighbour sampling
        x_sn = round(x_s);
        y_sn = round(y_s);
        
        % If source pixel is inside image, copy it; otherwise leave black
        if (x_sn >= 1) && (x_sn <= cols) && (y_sn >= 1) && (y_sn <= rows)
            Out(y_d, x_d) = In(y_sn, x_sn);
        else
            Out(y_d, x_d) = 0;
        end
        
    end
end

end
