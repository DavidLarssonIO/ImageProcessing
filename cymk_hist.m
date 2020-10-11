function [] = cymk_hist(picture)
cform = makecform('srgb2cmyk');
cmyk = applycform(picture, cform);
figure
%picture = histeq(picture);
Cyan = picture(:,:,1);
Magenta = picture(:,:,2);
Yellow = picture(:,:,3);
Black = picture(:,:,3);
%Get histValues for each channel
[yCyan, x] = imhist(Cyan);
[yMagenta, x] = imhist(Magenta);
[yYellow, x] = imhist(Yellow);
[yBlack, x] = imhist(Black);

area(x,yCyan,'EdgeColor','cyan','FaceColor','cyan','FaceAlpha',0.5)
hold on
area(x,yMagenta,'EdgeColor','magenta','FaceColor','magenta','FaceAlpha',0.5)
area(x(1:201),yYellow(1:201),'EdgeColor','yellow','FaceColor','yellow','FaceAlpha',0.5)
area(x(1:201),yBlack(1:201),'EdgeColor','black','FaceColor','black','FaceAlpha',0.5)
plot(x, yCyan, 'cyan', x, yMagenta, 'Magenta', x, yYellow, 'yellow',x,yBlack,'black');
end
