function idx = getLABScratches(rgb,lightness_bound,green_to_red_bound,blue_to_yellow_bound,show_pic)
% GETLABSCRATCHES   Detect scratches in RGB image (rgb) from specified
% thresholds by converting to LAB color space.
%
%   INPUTS
%       rgb: RGB image to analyze
%       lightness_bound: interval of brightness level of the image to be
%           analyzed (values between 0 to 100)
%       green_to_red_bound: interval of degree of red-to-green of the image
%           to be analyzed (values between -100 to 100)
%       blue_to_yellow_bound: interval of blue-to-yellow of the image
%           to be analyzed (values between -100 to 100)
%       show_pic: boolean representing if to display the (enhanced) images
%           and the detected scratches or not
%   RETURNS
%       idx: binary matrix of the same size as the original image where 1
%           represents a scratch and 0 represents no scratch

%   convert RGB image to  LAB image
    cform = makecform('srgb2lab');
    lab = applycform(rgb, cform);
    
%   enhance contrast in each of the three LAb layers using histogram
%   equalization
    lightness = histeq(lab(:,:,1));
    green_to_red = histeq(lab(:,:,2));
    blue_to_yellow = histeq(lab(:,:,3));
    
%   create binary matrices for each layer where the intensity is in
%   the corresponding specified interval from input lightness_bound,
%   green_to_red_bound and blue_to_yellow_bound. The binary matrices are
%   called l, a and b. 
    l1 = lightness>=lightness_bound(1);
    l2 = lab(:,:,1)<=lightness_bound(2);
    l = logical(l1.*l2);
    a1 = green_to_red>=green_to_red_bound(1);
    a2 = green_to_red<=green_to_red_bound(2);
    a = logical(a1.*a2);
    b1 = blue_to_yellow>=blue_to_yellow_bound(1);
    b2 = blue_to_yellow<=blue_to_yellow_bound(2);
    b = logical(b1.*b2);
    
%   create a binary matrix where the intensity is in the threshold
%   interval in all three layers
    idx = logical(l.*a.*b);
    
%   if input show_pic is true: display each enhanced image lightness,
%   green_to_red and blue_to_yellow and corresponding binary matrix (l, a,
%   b) where scratches have been detected
    if show_pic
        figure,clf
        subplot(2,3,4)
        imshow(lightness)
        subplot(2,3,5)
        imshow(green_to_red)
        subplot(2,3,6)
        imshow(blue_to_yellow)
        subplot(2,3,1)
        imshow(l,[0 1])
        subplot(2,3,2)
        imshow(a,[0,1])
        subplot(2,3,3)
        imshow(b,[0,1])
    end
end

