clear, clc
picture = webread('http://fy.chalmers.se/~romeo/RRY025/mfiles/film1_big.jpg');
sz = size(picture);
border = [5 3]; %Pixels
width = (sz(2)-2*border(2))/3; %Pixels
height = (sz(1)-4*border(1))/5; %Pixels
positions = zeros(5,3);
positions(1:1,2) = 1;
close all
picture_cell = getPictures(picture,width,height,border,positions);
for i=1:length(picture_cell)
    rgb_hist(picture_cell{i})
    %cymk_hist(picture_cell{i})
end