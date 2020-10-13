clear, clc, close all
picture = webread('http://fy.chalmers.se/~romeo/RRY025/mfiles/film1_big.jpg'); 
sz = size(picture);
border = [5 3]; % size of border dividing the images in the original grid image
width = (sz(2)-2*border(2))/3; %number of pixels (3 images broad->2 divisions)
height = (sz(1)-4*border(1))/5; %number of pixels (5 images high->4 divisions)
positions = zeros(5,3); % create zero matrix where each element represents one image in the original grid image film1_big.jpg
positions(3:3,2) = 1; % set elements representing the images in the middle column of original grid image to 1 (while the others maintain 0)
show_pic = false;
picture_cell = getPictures(picture,width,height,border,positions); % get images in the middle column
 for i = 1:length(picture_cell)
        pic = picture_cell{i};

%       Detect scratches in image i using three different representations
%       (RGB, CMYK and LAB) and save to index matrix idx if a scratch is
%       detected in all three representations
        r_bound = [0 200];
        g_bound =[0, 255];
        b_bound = [0, 255];
        rgb_idx = getRGBScratches(pic,r_bound,g_bound,b_bound,show_pic);
        fh = figure('Menu','none','ToolBar','none'); 
        ah = axes('Units','Normalize','Position',[0 0 1 1]);
        saveas(rgb_hist(pic,r_bound,g_bound,b_bound),"../rgb_hist.png")
        c_bound=[20 255];
        m_bound=[0, 250];
        y_bound=[0, 250];
        black_bound=[0, 235];
        fh = figure('Menu','none','ToolBar','none'); 
        ah = axes('Units','Normalize','Position',[0 0 1 1]);
        saveas(cmyk_hist(pic,c_bound,m_bound,y_bound,black_bound),"../cmyk_hist.png")
        cmyk_idx = getCMYKScratches(pic,c_bound,m_bound,y_bound,black_bound,show_pic);
        l_bound = [0 230];
        a_bound = [0 200];
        b_bound = [0 255];
        fh = figure('Menu','none','ToolBar','none'); 
        ah = axes('Units','Normalize','Position',[0 0 1 1]);
        saveas(lab_hist(pic,l_bound,a_bound,b_bound),"../lab_hist.png")
        
        lab_idx = getLABScratches(pic,l_bound,a_bound,b_bound,show_pic);
        fh = figure('Menu','none','ToolBar','none'); 
        ah = axes('Units','Normalize','Position',[0 0 1 1]);
        saveas(imshow(rgb_idx),"../rgb_idx.png")
        fh = figure('Menu','none','ToolBar','none'); 
        ah = axes('Units','Normalize','Position',[0 0 1 1]);
        saveas(imshow(setScratches(pic,rgb_idx)),"../rgb_fixed.png")
        fh = figure('Menu','none','ToolBar','none'); 
        ah = axes('Units','Normalize','Position',[0 0 1 1]);
        saveas(imshow(cmyk_idx),"../cmyk_idx.png")
        fh = figure('Menu','none','ToolBar','none'); 
        ah = axes('Units','Normalize','Position',[0 0 1 1]);
        saveas(imshow(setScratches(pic,cmyk_idx)),"../cmyk_fixed.png")
        fh = figure('Menu','none','ToolBar','none'); 
        ah = axes('Units','Normalize','Position',[0 0 1 1]);
        saveas(imshow(lab_idx),"../lab_idx.png")
        fh = figure('Menu','none','ToolBar','none'); 
        ah = axes('Units','Normalize','Position',[0 0 1 1]);
        saveas(imshow(setScratches(pic,lab_idx)),"../lab_fixed.png")
        %idx = logical(idx1.*idx2.*idx3); 

        se = strel('square',3); % create square structuring element of width 3 for simplifying closing operation below
        %idx = imclose(idx,se); % closing of matrix idx  
        edge_index =  logical(getEdgesDetection(pic)); % detect position of scratches
        saveas(imshow(setScratches(pic,edge_index)),"../edge_fixed.png")
        %edge_index = imclose(edge_index,se); % closing of matrix edge_index
        
%       cell containing binary matrix for image i where 1 represents
%       index where a scratch had been detected both using
%       edge detection and examining the different color spaces
        %scratch_index{i} = logical(idx.*edge_index);
 end
positions = zeros(5,3); % create zero matrix where each element represents one image in the original grid image film1_big.jpg
positions(1:5,2) = 1; % set elements representing the images in the middle column of original grid image to 1 (while the others maintain 0)
show_pic = false;
picture_cell = getPictures(picture,width,height,border,positions); % get images in the middle column
for i=1:length(picture_cell)
    pic = picture_cell{i};
    fh = figure('Menu','none','ToolBar','none'); 
    ah = axes('Units','Normalize','Position',[0 0 1 1]);
    saveas(imshow(pic),"../Scratch"+i+".png")
end
positions = zeros(5,3); % create zero matrix where each element represents one image in the original grid image film1_big.jpg
positions(1:5,3) = 1; % set elements representing the images in the middle column of original grid image to 1 (while the others maintain 0)
show_pic = false;
picture_cell = getPictures(picture,width,height,border,positions); % get images in the middle column
for i=1:length(picture_cell)
    pic = picture_cell{i};
    fh = figure('Menu','none','ToolBar','none'); 
    ah = axes('Units','Normalize','Position',[0 0 1 1]);
    saveas(imshow(pic),"../ThereFix"+i+".png")
end
positions = zeros(5,3); % create zero matrix where each element represents one image in the original grid image film1_big.jpg
positions(1:5,2) = 1; % set elements representing the images in the middle column of original grid image to 1 (while the others maintain 0)
picture_cell = getPictures(picture,width,height,border,positions); % get images in the middle column
show_pic = false;
% Detect scracthes in each of the images in the middle column 
scratch_index = getScratches(picture_cell,show_pic); 

% Repair pixels (by taking the time development into account) where
% scratches have been detected in each of the images and save the indices
% which contain a scratch but haven't been repaired. 
[fixed_frames_cell,index_cell] = setEdgeReparation(picture_cell,scratch_index); 
for i=1:length(picture_cell)
    pic = fixed_frames_cell{i};
    idx = index_cell{i}; % indices with scratches that haven't been repaired
    pic = setScratches(pic,idx);
    fh = figure('Menu','none','ToolBar','none'); 
    ah = axes('Units','Normalize','Position',[0 0 1 1]);
    saveas(imshow(pic),"../OurFix"+i+".png")
end 