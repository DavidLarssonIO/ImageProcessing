function picture_cell = getPictures(picture,width,height,border,positions)
[Y, X] = find(positions == 1);
picture_cell = cell(size(Y));
for i = 1:length(X)
    x = X(i);
    y = Y(i);
    x_start = (width+border(2))*(x-1)+1;
    x_stop = (width+border(2))*(x-1)+width;
    y_start = (height+border(1))*(y-1)+1;
    y_stop = (height+border(1))*(y-1)+height;
    x_pick = x_start:x_stop;
    y_pick = y_start:y_stop;
    picture_cell{i} = picture(y_pick,x_pick,:);
end
end