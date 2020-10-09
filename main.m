clear, clc
picture = webread('http://fy.chalmers.se/~romeo/RRY025/mfiles/film1_big.jpg');
sz = size(picture);
border = [5 3]; %Pixels
width = (sz(2)-2*border(2))/3; %Pixels
height = (sz(1)-4*border(1))/5; %Pixels
positions = zeros(5,3);
positions(1:5,2) = 1;

picture_cell = getPictures(picture,width,height,border,positions);
show_pic = false;
scratch_index = getSchratches(picture_cell,show_pic);
[fixed_frames_cell,index_cell] = setEdgeReparation(picture_cell,scratch_index);

close all
for i = 1:5
    pic = fixed_frames_cell{i};
    idx = index_cell{i};
    figure
    pic = setScratches(pic,idx);
    imshow(pic)
end