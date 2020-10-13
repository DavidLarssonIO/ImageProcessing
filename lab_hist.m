function fig = lab_hist(picture,l_bound,a_bound,b_bound)
cform = makecform('srgb2lab');
picture = applycform(picture, cform);
fig = figure;
picture = histeq(picture);
Ligh = picture(:,:,1);
A = picture(:,:,2);
B = picture(:,:,3);
%Get histValues for each channel
[yLigh, x_lig] = imhist(Ligh);
[yA, x_A] = imhist(A);
[yB, x_b] = imhist(B);
plot(x_b, yB, 'Blue',x_A, yA, 'Green',x_lig, yLigh, 'Red');
hold on
x_lig = x_lig(l_bound(1)+1:l_bound(2)+1);
yLigh = yLigh(l_bound(1)+1:l_bound(2)+1);
x_A = x_A(a_bound(1)+1:a_bound(2)+1);
yA = yA(a_bound(1)+1:a_bound(2)+1);
x_b = x_b(b_bound(1)+1:b_bound(2)+1);
yB= yB(b_bound(1)+1:b_bound(2)+1);
area(x_b(yB>0),yB(yB>0),'EdgeColor','b','FaceColor','b','FaceAlpha',0.5)
area(x_A(yA>0),yA(yA>0),'EdgeColor','g','FaceColor','g','FaceAlpha',0.5)
area(x_lig(yLigh>0),yLigh(yLigh>0),'EdgeColor','r','FaceColor','r','FaceAlpha',0.5)
xlim([0 256])
end