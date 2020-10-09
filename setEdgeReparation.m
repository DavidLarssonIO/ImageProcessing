function [fixed_frames_cell,tmp_index_cell] = setEdgeReparation(picture_cell,index_cell)
tmp_index_cell = cell(size(index_cell));
fixed_frames_cell = cell(size(picture_cell));
y = [7,6,6,5];
x = [4,0,0,0];
for i = 1:length(picture_cell)
    if i == 1
         [fixed_frame,not_fixed_index] = fixFrame(picture_cell{i},picture_cell{i+1},index_cell{i},index_cell{i+1},[x(1),y(1)]);
         fixed_frames_cell{i} = fixed_frame;
         tmp_index_cell{i} = not_fixed_index;
    elseif i == length(picture_cell)
         [fixed_frame,not_fixed_index] = fixFrameTMinus(picture_cell{i},picture_cell{i-1},index_cell{i},index_cell{i-1},[x(4),y(4)]);
         fixed_frames_cell{i} = fixed_frame;
         tmp_index_cell{i} = not_fixed_index;
    else
        [fixed_frame,not_fixed_index] = fixFrameTMinus(picture_cell{i},picture_cell{i-1},index_cell{i},index_cell{i-1},[x(i-1),y(i-1)]);
        [fixed_frame,not_fixed_index] = fixFrame(fixed_frame,picture_cell{i+1},not_fixed_index,index_cell{i+1},[x(i),y(i)]);
        fixed_frames_cell{i} = fixed_frame;
        tmp_index_cell{i} = not_fixed_index;       
    end
end
end