function [frame1, frame2] = shiftFrame(frame1,frame2,shift)
% SHIFTFRAME Overlap of two images based on the magnitude of
% the shift between them as a consequence of time development 

%   INPUTS
%       frame1: first image
%       frame2: second image
%       shift: number of pixel of shift of the bakground between the two
%           images in the x and y direction
%   RETURNS
%       frame1: the part of the first image which overlaps with the second
%       frame2: the part of the second image shich overlaps with the first


%   Since the background moves to the left and/or down between to
%   consecutive images the number of pixels equal to the shift in the y (x)
%   direction from the left (bottom) of the first image will not exist in
%   the second image. The same is true but from right (top) for the second
%   image. Therefore: remove these pixels and only include the ones which
%   exist in both images.
    sz = size(frame1);
    frame1 = frame1(1:sz(1)-shift(1),1:sz(2)-shift(2),:);
    frame2 = frame2(1+shift(1):sz(1),1+shift(2):sz(2),:);
end