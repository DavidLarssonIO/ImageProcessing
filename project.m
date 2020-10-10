clc, clear

% downloading the original image 
image = im2double(webread('http://fy.chalmers.se/~romeo/RRY025/mfiles/film1_big.jpg'));
figure, imshow(image, [])

%% extracting middle frames
[height, width, ~] = size(image); 

fr_height = height/5;
fr_width = width/3; 

left_column = image(:, 1:fr_width, :);
middle_column = image(:, fr_width:2*fr_width, :);
right_column = image(:, 2*fr_width:end,:); 

figure
subplot(1,3,1)
imshow((1-left_column),[])
subplot(1,3,2)
imshow((1-middle_column),[])
subplot(1,3,3)
imshow((1-right_column),[])

%%
middle_frame_1 = image(1:fr_height-2, fr_width+1:2*fr_width-3, :);
middle_frame_2 = image(fr_height+3:2*fr_height, fr_width+1:2*fr_width-3, :);
middle_frame_3 = image(2*fr_height+3:3*fr_height, fr_width+1:2*fr_width-3, :);
middle_frame_4 = image(3*fr_height+3:4*fr_height, fr_width+1:2*fr_width-3, :);
middle_frame_5 = image(4*fr_height+3:end, fr_width+1:2*fr_width-3, :);

% figure()
% subplot(5,1,1)
% imshow((1-middle_frame_1), [])
% subplot(5,1,2)
% imshow((1-middle_frame_2), [])
% subplot(5,1,3)
% imshow((1-middle_frame_3), [])
% subplot(5,1,4)
% imshow((1-middle_frame_4), [])
% subplot(5,1,5)
% imshow((1-middle_frame_5), [])

frame_array = vertcat(middle_frame_1, middle_frame_2,  middle_frame_3, middle_frame_4, middle_frame_5);
figure()
subplot(1,3,1)
imshow(frame_array(:,:,1),[])
title('Red channel')
subplot(1,3,2)
imshow(frame_array(:,:,2),[])
title('Green channel')
subplot(1,3,3)
imshow(frame_array(:,:,3),[])
title('Blue channel')

%image_array = cat(3, middle_frame_1, middle_frame_2,  middle_frame_3, middle_frame_4, middle_frame_5);

% for i = 1:5
%     frame_length = size(frame_array,1)/5;
%     frame = frame_array((i-1)*frame_length+1:i*frame_length, : ,1);
%     figure()
%     imshow(frame,[])
% end

%% taking the difference in time 
% hmm, but at the end we need to get 5 frames, how should it be done then? 
diff_1_R = middle_frame_2(:,:,1) - middle_frame_1(:,:,1);
diff_2_R = middle_frame_3(:,:,1) - middle_frame_2(:,:,1);
diff_3_R = middle_frame_4(:,:,1) - middle_frame_3(:,:,1);
diff_4_R = middle_frame_5(:,:,1) - middle_frame_4(:,:,1);

figure()
subplot(1,2,1)
imshow(diff_1_R, [])
subplot(1,2,2)
imshow(diff_2_R, [])
% subplot(1,3,3)
% imshow(diff_3_R, [])
% subplot(4,1,4)
% imshow(diff_4, [])

diff_1_G = middle_frame_2(:,:,2) - middle_frame_1(:,:,2);
diff_2_G = middle_frame_3(:,:,2) - middle_frame_2(:,:,2);
diff_3_G = middle_frame_4(:,:,2) - middle_frame_3(:,:,2);
diff_4_G = middle_frame_5(:,:,2) - middle_frame_4(:,:,2);

figure()
subplot(1,2,1)
imshow(diff_1_G, [])
subplot(1,2,2)
imshow(diff_2_G, [])
% subplot(1,3,3)
% imshow(diff_3_G, [])

diff_1_B = middle_frame_2(:,:,3) - middle_frame_1(:,:,3);
diff_2_B = middle_frame_3(:,:,3) - middle_frame_2(:,:,3);
diff_3_B = middle_frame_4(:,:,3) - middle_frame_3(:,:,3);
diff_4_B = middle_frame_5(:,:,3) - middle_frame_4(:,:,3);

figure()
subplot(1,2,1)
imshow(diff_1_B, [])
subplot(1,2,2)
imshow(diff_2_B, [])
% subplot(1,3,3)
% imshow(diff_3_B, [])

%% detecting edges 
% vertical filtering 
sbv = [1 2 1; 0 0 0; -1 -2 -1];
% horizontal filtering 
sbh = [1 0 -1; 2 0 -2; 1 0 -1];

diff_1_R_BW = im2bw(diff_1_R, 0.1);
figure, imshow(diff_1_R_BW, []); 
% detecting vertical edges 
vert_edge_R = filter2(sbh, diff_1_R);
vert_edge_R2 = filter2(sbh, diff_1_R_BW);
%figure, imshow(vert_edge_R, [])

% detecting horizontal edges
horz_edge_R = filter2(sbv, diff_1_R); 
%figure, imshow(horz_edge_R, [])

% once binarized 
vert_edge_R_BW = im2bw(vert_edge_R, 0.6);
% twice binarized 
vert_edge_R_BW2 = im2bw(vert_edge_R2, 0.6);

horz_edge_R_BW = im2bw(horz_edge_R, 0.6);

figure()
subplot(1,2,1)
imshow(vert_edge_R_BW, []);
subplot(1,2,2)
imshow(vert_edge_R_BW2, []);

%% filtering 

[L, n] = bwlabel(vert_edge_R_BW); 
%CC =bwconncomp(vert_edge_R_BW,4); 
%%measurements = regionprops(L, 'Area');


% matlab hint 

[r,c] = find(L == 1); %==> r=114, c = 1 (only one pixel) 
[r,c] = find(L == 2);
 measure = find(L==2);
 
treshold = 30; 
temp_mat = zeros(1000, n);
for i = 1:n
    temp_mat(1:length(find(L==i)),i) = find(L==i);
end


measurements = regionprops(L, 'Area');










