function [Out] = Rotate(In, Theta)

% Get image size
[rows, cols] = size(In);

% Create output image filled with zeros (black)
Out = zeros(rows, cols);

% Compute image centre
cx = (cols + 1) / 2;
cy = (rows + 1) / 2;

% Inverse rotation matrix
R_inv = [ cos(Theta)  sin(Theta);
         -sin(Theta)  cos(Theta) ];

% Loop over every pixel in destination image
for y_d = 1:rows
    for x_d = 1:cols

        % Shift origin to image centre
        coord_d = [x_d - cx; y_d - cy];

        % Apply inverse rotation to find source coordinate
        coord_s = R_inv * coord_d;

        % Shift back to original coordinate system
        x_s = coord_s(1) + cx;
        y_s = coord_s(2) + cy;

        % Nearest neighbour interpolation
        x_nn = round(x_s);
        y_nn = round(y_s);

        % Check if inside source image
        if x_nn >= 1 && x_nn <= cols && y_nn >= 1 && y_nn <= rows
            Out(y_d, x_d) = In(y_nn, x_nn);
        else
            Out(y_d, x_d) = 0; % paint black if outside
        end
    end
end
end
