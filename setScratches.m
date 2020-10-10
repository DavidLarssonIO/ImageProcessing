function pic = setScratches(rgb,scratches)
% SETSCRATCHES Repair RGB image with detected scratches using mean filter
% of k-nearest neighbours.
%
%   INPUTS
%       rgb: RGB image to be repaired
%       scratches: binary matrix containing detected scratches (1 if
%       scratch, else 0)
%   RETURNS
%       pic: repaired image

    [nx,ny] = size(scratches);
    [row,col] = find(scratches==1); % indices of detected scratches to use (for knn-search)
    idx = find(scratches==1); % indices of detected scratches (for plot)
    [r,c] = find(scratches == 0); % indices of  no detected scratches (for knn-search)
    
%   Detect nearest neighbours of scratches. Include all neightbours on a
%   distance equal to the minimal.
    scratches_nn = knnsearch([r,c],[row col],'k',1,'IncludeTies',true);  
    
%   Separate the image in red, green and blue color layers
    red = rgb(:,:,1);
    green = rgb(:,:,2);
    blue = rgb(:,:,3);

%   Repair the scratches in the three color layers by replacing the
%   scratched pixels with the mean of the nearest neighbours pixel values.
    for i=1:length(scratches_nn)
        ind = sub2ind(size(scratches),r(scratches_nn{i}),c(scratches_nn{i})); % convert subscripts to linear indices 
        red(idx(i)) = floor(mean(red(ind)));
        green(idx(i)) = floor(mean(green(ind)));
        blue(idx(i)) = floor(mean(blue(ind)));
    end
    
    pic = cat(3,red,green,blue); % concatenate the three color layers
end