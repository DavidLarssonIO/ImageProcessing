clear, clc, close all
picture = webread('http://fy.chalmers.se/~romeo/RRY025/mfiles/film1_big.jpg'); 
sz = size(picture);
border = [5 3]; % size of border dividing the images in the original grid image
width = (sz(2)-2*border(2))/3; %number of pixels (3 images broad->2 divisions)
height = (sz(1)-4*border(1))/5; %number of pixels (5 images high->4 divisions)
positions = zeros(5,3); % create zero matrix where each element represents one image in the original grid image film1_big.jpg
positions(1:5,2) = 1; % set elements representing the images in the middle column of original grid image to 1 (while the others maintain 0)

picture_cell = getPictures(picture,width,height,border,positions); % get images in the middle column
show_pic = false;
% Detect scracthes in each of the images in the middle column 
scratch_index = getScratches(picture_cell,show_pic); 
%%
% Repair pixels (by taking the time development into account) where
% scratches have been detected in each of the images and save the indices
% which contain a scratch but haven't been repaired. 
[fixed_frames_cell,index_cell] = setEdgeReparation(picture_cell,scratch_index); 

close all
for i = 1:5
    pic = fixed_frames_cell{i};
    idx = index_cell{i}; % indices with scratches that haven't been repaired
    pic = setScratches(pic,idx); % repair the scratches which haven't been repaired yet using mean of k nearest neighbours 
    subplot(5,2,2*i-1)
    imshow(picture_cell{i})
    subplot(5,2,2*i)
    imshow(pic)
end