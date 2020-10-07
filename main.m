clear, clc
%figure(1),clf
picture = webread('http://fy.chalmers.se/~romeo/RRY025/mfiles/film1_big.jpg');
sz = size(picture);
border = [5 3]; %Pixels
width = (sz(2)-2*border(2))/3; %Pixels
height = (sz(1)-4*border(1))/5; %Pixels
positions = zeros(5,3);
positions(1:5,2) = 1;
%positions(1,3) = 1;

picture_cell = getPictures(picture,width,height,border,positions);
close all
show_pic = false;
for i = 1:length(picture_cell)
    pic = picture_cell{i};
    %pic = pic(1:5,1:5,:)
    %cform = makecform('srgb2cmyk');
    %cmyk = applycform(pic, cform);
    idx1 = getCMYKScratches(pic,[30 255],[0 80],[0 150],[0 100],show_pic);
    idx2 = getRGBScratches(pic,[0 200],[0 240],[0 255],show_pic);
    idx3 = getLABScratches(pic,[120 210],[90 125], [80 140],show_pic);%
    
    sbv = [1 2 1; 0 0 0; -1 -2 -1];
    sbh = [1 0 -1; 2 0 -2; 1 0 -1];
    temp = im2double(picture_cell{i});
    thresh = 0.3;
    vert_edges = logical(filter2(sbh, temp(:,:,1))>thresh);
    vert_edges2 = logical(filter2(sbh, temp(:,:,1))<-thresh);
    vert_edges = circshift(vert_edges,1,2);
    vert_edges2 = circshift(vert_edges2,-1,2);
    hori_edges = logical(filter2(sbv, temp(:,:,1))>thresh);
    hori_edges = circshift(hori_edges,1,1);
    hori_edges2 = logical(filter2(sbv, temp(:,:,1))<-thresh);
    hori_edges2 = circshift(hori_edges2,-1,1);
    edge_index = hori_edges+hori_edges2+vert_edges+vert_edges2;
    idx = logical(edge_index.*idx1);%idx1.*idx2.*idx3.*idx1.*idx2.*idx3.*(
    %idx = idx(1:5,1:5)
    %idx = getCMYKScratches(pic,[0 255],[0 255],[0 255],[0 255],show_pic);%[0 30],[0 150],[0 100]
    %
    figure('units','normalized','outerposition',[0 0 1 1])
    %figure(1),clf
    subplot(1,2,1)
    imshow(picture_cell{i},[])
    %subplot(1,3,2)
    %imshow(setScratchesWhite(pic,idx))
    subplot(1,2,2)
    imshow(setScratches(pic,idx))
end