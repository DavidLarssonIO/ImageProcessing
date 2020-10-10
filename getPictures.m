function picture_cell = getPictures(picture,width,height,border,positions)
% GETPICTURES   Extract specified images from grid image
%
%   INPUTS
%       picture: original grid image from where to extract specific images
%       width: width of the images to be extracted
%       height: height of the images to be extracted
%       border: pixel size of border in x and y direction  dividing the
%           images in the grid image. Note: no border around the grid image!
%       positions: binary matrix of the same size as the number of images
%           in the grid image where 1 represents images to be extracted and
%           0 images to be left out
%   RETURNS
%       picture_cell: cell array where each cell contains one of the
%       extracted images


    [Y, X] = find(positions == 1); % find index of the images to be extracted (where Y: row and X: column of grid image)
    picture_cell = cell(size(Y)); 

%   extract and save each image (specified by position [Y,X] above) in a cell
    for i = 1:length(X)
        x = X(i);
        y = Y(i);

%   determine start and stop position of image i in x and y direction
        x_start = (width+border(2))*(x-1)+1;
        x_stop = (width+border(2))*(x-1)+width;
        y_start = (height+border(1))*(y-1)+1;
        y_stop = (height+border(1))*(y-1)+height;

%   choose every pixel in the interval between the start and stop
%   positions from above and save it in cell i in cell array picture_cell 
        x_pick = x_start:x_stop;
        y_pick = y_start:y_stop;
        picture_cell{i} = picture(y_pick,x_pick,:);
    end
end