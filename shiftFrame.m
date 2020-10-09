function [frame1, frame2] = shiftFrame(frame1,frame2,shift)
    sz = size(frame1);
    frame1 = frame1(1:sz(1)-shift(1),1:sz(2)-shift(2),:);
    frame2 = frame2(1+shift(1):sz(1),1+shift(2):sz(2),:);
end