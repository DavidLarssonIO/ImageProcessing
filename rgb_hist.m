function [] = rgb_hist(picture)
figure
picture = histeq(picture);
Red = picture(:,:,1);
Green = picture(:,:,2);
Blue = picture(:,:,3);
%Get histValues for each channel
[yRed, x] = imhist(Red);
[yGreen, x] = imhist(Green);
[yBlue, x] = imhist(Blue);
plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');
area(x(yBlue>0),yBlue(yBlue>0),'EdgeColor','b','FaceColor','b','FaceAlpha',0.5)
hold on
area(x(yGreen>0),yGreen(yGreen>0),'EdgeColor','g','FaceColor','g','FaceAlpha',0.5)
x_tmp = x(1:201);
yRed_tmp = yRed(1:201);
area(x_tmp(yRed_tmp>0),yRed_tmp(yRed_tmp>0),'EdgeColor','r','FaceColor','r','FaceAlpha',0.5)
end

