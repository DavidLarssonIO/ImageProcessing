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

    sbv = [ -1 -2 -1; 0 0 0;1 2 1] % Sobel vertical filter
    sbh = [-1 0 1; -2 0 2; -1 0 1] % Sobel horizontal filter
    picture = im2double(picture);
    red = 1-picture(:,:,1);
    thresh = 0.3; % threshold to use in Sobel filters
    % create binary matrices containing horizontal and vertical edges
    % respectively 
    vert_edges_l = logical(filter2(sbh, red)>thresh);
    vert_edges_r = logical(filter2(sbh, red)<-thresh);
    vert_edges_l = circshift(vert_edges_l,1,2);
    vert_edges_r = circshift(vert_edges_r,-1,2);
    hori_edges_u = logical(filter2(sbv, red)>thresh);
    hori_edges_u = circshift(hori_edges_u,1,1);
    hori_edges_d = logical(filter2(sbv, red)<-thresh);
    hori_edges_d = circshift(hori_edges_d,-1,1);
    edge_index = logical(hori_edges_u+hori_edges_d+vert_edges_l+vert_edges_r);
end

