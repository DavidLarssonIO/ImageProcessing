function [fixed_frame,not_fixed_index] = fixFrame(frame,frame_t,idx,idx_t,shift)
% FIXFRAME Shift image to correct for time development. Used to be able to
% compare the backgrounds in one image with the next image in the time
% sequence.
%
%   INPUTS
%       frame: image to shift
%       frame_t: next image in the time sequence (i.e. image on next row in
%           the original grid image film1_big.jpg)
%       idx: matrix containing the detected scratches for the image to be
%           shifted
%       idx_t: matrix containing the detected scratches in the image next
%           after the image to be analyzed in the time sequence
%       shift: movement of background in pixel in x and y direction between
%           the two consecutive images
%   RETURNS
%       fixed_frame: the repaired image
%       not_fixed_index: binary matrix containing which pixels have
%           scratches which haven't been repaired (1) and which are repaired or
%           don't have scratches (0)

%   Shift the two images to only include the area of the background that 
%   exists in both images.
    [frame,frame_t] = shiftFrame(frame,frame_t,shift); 
    [idx,idx_t] = shiftFrame(idx,idx_t,shift);

%   Repair the image by replacing the scratched pixel in the first image
%   with the corresponding pixel value in the second image (if it isn't
%   scratched). Do this for all three RGB color layers.
    repair_index = idx>idx_t; 
    not_fixed_index = idx.*idx_t;
    for i=1:3
        color = frame(:,:,i);
        color_t = frame_t(:,:,i);
        color(repair_index) = color_t(repair_index);
        frame(:,:,i) = color;
    end

    fixed_frame = frame;
end