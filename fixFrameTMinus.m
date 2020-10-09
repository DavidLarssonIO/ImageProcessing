function [fixed_frame,not_fixed_index] = fixFrameTMinus(frame,frame_t,idx,idx_t,shift)
[frame_t,frame] = shiftFrame(frame_t,frame,shift);
[idx_t,idx] = shiftFrame(idx_t,idx,shift);
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