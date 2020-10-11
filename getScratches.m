function scratch_index = getSchratches(picture_cell,show_pic)
% SCRATCHINDEX   Detect position of scratches of image(s) using RGB, CMYK
%                and LAB color space and edge detection using vertical and
%                horizontal Sobel filter.
%
%   INPUTS
%       picture_cell: cell (array) containing the image(s) so be analyzed
%       show_pic: boolean of displaying the scratches or not
%   RETURNS
%       scratch_index: cell array of the same length as number of images to
%           analyze. Each cell contains a binary matrix of the positions of
%           the detected scratches in the image (1: scratch, 0: no scratch)

    scratch_index = cell(length(picture_cell),1);

%   Detect position of scratches in each image in cell array picture_cell
    for i = 1:length(picture_cell)
        pic = picture_cell{i};

%       Detect scratches in image i using three different representations
%       (RGB, CMYK and LAB) and save to index matrix idx if a scratch is
%       detected in all three representations
        idx1 = getRGBScratches(pic,[0 200],[0, 255],[0, 255],show_pic);
        idx2 = getCMYKScratches(pic,[20 255],[0, 250],[0, 250],[0, 235],show_pic);
        idx3 = getLABScratches(pic,[0 230],[0 200], [0 255],show_pic);
        idx = logical(idx1.*idx2.*idx3); 

        se = strel('square',3); % create square structuring element of width 3 for simplifying closing operation below
        idx = imclose(idx,se); % closing of matrix idx  
        edge_index = getEdgesDetection(pic); % detect position of scratches
        edge_index = imclose(edge_index,se); % closing of matrix edge_index
        
%       cell containing binary matrix for image i where 1 represents
%       index where a scratch had been detected both using
%       edge detection and examining the different color spaces
        scratch_index{i} = logical(idx.*edge_index);
    end
end
