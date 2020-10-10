function edge_index = getEdgesDetection(picture)
% GETEDGESDETECTION Detect vertical and horizontal edges of an image uing 
%   Sobel horizontal and vertical filter
%
%   INPUTS
%       picture: image to be analyzed
%   RETURNS
%       edge_index: matrix of the same size as the original image (picture)
%           containing information about vertical and horizontal edges.
%           Each element is in the range 0-4.

    sbv = [1 2 1; 0 0 0; -1 -2 -1]; % Sobel vertical filter
    sbh = [1 0 -1; 2 0 -2; 1 0 -1]; % Sobel horizontal filter
    temp = im2double(picture);
    thresh = 0.3; % threshold to use in Sobel filters
    
    % create binary matrices containing horizontal and vertical edges
    % respectively 
    vert_edges = logical(filter2(sbh, temp(:,:,1))>thresh);
    vert_edges2 = logical(filter2(sbh, temp(:,:,1))<-thresh);
    vert_edges = circshift(vert_edges,1,2);
    vert_edges2 = circshift(vert_edges2,-1,2);
    hori_edges = logical(filter2(sbv, temp(:,:,1))>thresh);
    hori_edges = circshift(hori_edges,1,1);
    hori_edges2 = logical(filter2(sbv, temp(:,:,1))<-thresh);
    hori_edges2 = circshift(hori_edges2,-1,1);
       
    edge_index = hori_edges+hori_edges2+vert_edges+vert_edges2;
end

