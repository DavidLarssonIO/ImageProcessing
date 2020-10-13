function fig = cmyk_hist(picture,c_bound,m_bound,y_bound,black_bound)
cform = makecform('srgb2cmyk');
picture = applycform(picture, cform);
fig = figure;
picture = histeq(picture);
Cyan = picture(:,:,1);
Magenta = picture(:,:,2);
Yellow = picture(:,:,3);
Black = picture(:,:,4);
%Get histValues for each channel
[yCyan, x_cyan] = imhist(Cyan);
[yMagenta, x_magenta] = imhist(Magenta);
[yYellow, x_yellow] = imhist(Yellow);
[yBlack, x_black] = imhist(Black);
plot(x_black,yBlack,'black',x_yellow, yYellow, 'y',x_magenta, yMagenta, 'm',x_cyan, yCyan, 'c');
hold on
x_cyan = x_cyan(c_bound(1)+1:c_bound(2)+1);
yCyan = yCyan(c_bound(1)+1:c_bound(2)+1);
x_magenta = x_magenta(m_bound(1)+1:m_bound(2)+1);
yMagenta = yMagenta(m_bound(1)+1:m_bound(2)+1);
x_yellow = x_yellow(y_bound(1)+1:y_bound(2)+1);
yYellow = yYellow(y_bound(1)+1:y_bound(2)+1);
x_black = x_black(black_bound(1)+1:black_bound(2)+1);
yBlack = yBlack(black_bound(1)+1:black_bound(2)+1);
area(x_black(yBlack>0),yBlack(yBlack>0),'EdgeColor','black','FaceColor','black','FaceAlpha',0.5)
area(x_yellow(yYellow>0),yYellow(yYellow>0),'EdgeColor','y','FaceColor','y','FaceAlpha',0.5)
area(x_magenta(yMagenta>0),yMagenta(yMagenta>0),'EdgeColor','m','FaceColor','m','FaceAlpha',0.5)
area(x_cyan(yCyan>0),yCyan(yCyan>0),'EdgeColor','c','FaceColor','c','FaceAlpha',0.5)
xlim([0 256])
end