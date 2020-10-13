function fig = rgb_hist(picture,r_bound,g_bound,b_bound)
fig = figure;
picture = histeq(picture);
Red = picture(:,:,1);
Green = picture(:,:,2);
Blue = picture(:,:,3);
%Get histValues for each channel
[yRed, x_red] = imhist(Red);
[yGreen, x_green] = imhist(Green);
[yBlue, x_blue] = imhist(Blue);
plot(x_blue, yBlue, 'Blue',x_green, yGreen, 'Green',x_red, yRed, 'Red');
hold on
x_red = x_red(r_bound(1)+1:r_bound(2)+1);
yRed = yRed(r_bound(1)+1:r_bound(2)+1);
x_green = x_green(g_bound(1)+1:g_bound(2)+1);
yGreen = yGreen(g_bound(1)+1:g_bound(2)+1);
x_blue = x_blue(b_bound(1)+1:b_bound(2)+1);
yBlue= yBlue(b_bound(1)+1:b_bound(2)+1);
area(x_blue(yBlue>0),yBlue(yBlue>0),'EdgeColor','b','FaceColor','b','FaceAlpha',0.5)
area(x_green(yGreen>0),yGreen(yGreen>0),'EdgeColor','g','FaceColor','g','FaceAlpha',0.5)
area(x_red(yRed>0),yRed(yRed>0),'EdgeColor','r','FaceColor','r','FaceAlpha',0.5)
xlim([0 256])
end