function [fixed_frames_cell,tmp_index_cell] = setEdgeReparation(picture_cell,index_cell)
% SETEDGEREPARATION 
%
%   INPUTS
%       picture_cell: cell array containing the images to be repared
%       index_cell: cell array containing indices of detected scratches for
%           each of the images to be repared
%   RETURNS
%       fixed_frames_cell: cell array of the same size as picture_cell
%           (i.e number of images)
%       tmp_index_cell: cell array of the same size as picture_cell (i.e.
%           number of images)


    tmp_index_cell = cell(size(index_cell));
    fixed_frames_cell = cell(size(picture_cell));
  
%   vectors containing the shift in number of pixels in horizontal and vertical direction
%   of the background between to consecutive images in the time
%   sequence (i.e. the images in column 2 of the original grid image
%   film1_big.jpg)
    horizontal_camera_comp = [7,6,6,5]; 
    vertical_camera_comp = [4,0,0,0];

%   Repair the scratches in each image in picture_cell by taking the time
%   development into account.
%       fixed_frame: the repaired image i (save in cell i in cell array
%           fixed_frames_cell)
%       not_fixed_index: binary matrix containing which pixels in image i
%       that contain scratches but haven't been repaired (save in cell i in
%       cell array tmp_index_cell)
    for i = 1:length(picture_cell)
        if i == 1
%           using function fixFrame to compare the first picture with the
%           second 
            [fixed_frame,not_fixed_index] = fixFrame(picture_cell{i},picture_cell{i+1},index_cell{i},index_cell{i+1},[vertical_camera_comp(1),horizontal_camera_comp(1)]);
            fixed_frames_cell{i} = fixed_frame;
            tmp_index_cell{i} = not_fixed_index;
        elseif i == length(picture_cell)
%           using function fixFrameTMinus to compare the last image with
%           the image before that one
            [fixed_frame,not_fixed_index] = fixFrameTMinus(picture_cell{i},picture_cell{i-1},index_cell{i},index_cell{i-1},[vertical_camera_comp(end),horizontal_camera_comp(end)]);
            fixed_frames_cell{i} = fixed_frame;
            tmp_index_cell{i} = not_fixed_index;
        else
%           using function fixFrame and fixFrameTMinus to compare the image
%           with the one before and after
            [fixed_frame,not_fixed_index] = fixFrameTMinus(picture_cell{i},picture_cell{i-1},index_cell{i},index_cell{i-1},[vertical_camera_comp(i-1),horizontal_camera_comp(i-1)]);
            [fixed_frame,not_fixed_index] = fixFrame(fixed_frame,picture_cell{i+1},not_fixed_index,index_cell{i+1},[vertical_camera_comp(i),horizontal_camera_comp(i)]);
            fixed_frames_cell{i} = fixed_frame;
            tmp_index_cell{i} = not_fixed_index;       
        end
    end
end