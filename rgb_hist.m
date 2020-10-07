function [] = rgb_hist(picture)
figure
subplot(2,1,1)
imshow(picture)

Red = picture(:,:,1);
Green = picture(:,:,2);
Blue = picture(:,:,3);
%Get histValues for each channel
[yRed, x] = imhist(Red);
[yGreen, x] = imhist(Green);
[yBlue, x] = imhist(Blue);
subplot(2,1,2)
plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');
end

