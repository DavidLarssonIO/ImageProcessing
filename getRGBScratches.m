function idx = getRGBScratches(rgb,red_bound,green_bound,blue_bound,show_pic)
% GETRGBSCRATCHES   Detect scratches in RGB image (rgb) from specified
% thresholds
%
%   INPUTS
%       rgb: RGB image to analyze
%       red_bound: interval of intensity of red color layer to be analyzed
%           (values between 0 and 255)
%       green_bound: interval of intensity of green color layer to be
%           analyzed (values between 0 and 255)
%       blue_bound: interval of intensity of blue color layer to be
%           analyzed (values between 0 and 255)
%       show_pic: boolean representing if to display the (enhanced) images
%           and the detected scratches or not
%   RETURNS
%       idx: binary matrix of the same size as the original image where 1
%           represents a scratch and 0 represents no scratch

%   Enhance contrast of the image using histogram equalization
    rgb = histeq(rgb);
    
    red = rgb(:,:,1);
    green = rgb(:,:,2);
    blue = rgb(:,:,3);
    
%   Create binary matrices for each color layer where the intensity is in the
%   corresponding specified interval from input red_bound, green_bound
%   and blue_bound. The binary matrices are called r,g and b. 
    r1 = red>=red_bound(1);
    r2 = red<=red_bound(2);
    r = logical(r1.*r2); 
    g1 = green>=green_bound(1);
    g2 = green<=green_bound(2);
    g = logical(g1.*g2);
    b1 = blue>=blue_bound(1);
    b2 = blue<=blue_bound(2);
    b = logical(b1.*b2);
    
%   Create a binary matrix where the intensity is in the threshold
%   interval in all three color layers
    idx = logical(r.*g.*b);
    
%   If input show_pic is true: display each enhanced image red, green and
%   blue and corresponding binary matrix (r, g and b) where scratches
%   have been detected
    if show_pic
        figure,clf
        subplot(2,3,4)
        imshow(red)
        subplot(2,3,5)
        imshow(green)
        subplot(2,3,6)
        imshow(blue)
        subplot(2,3,1)
        imshow(r,[0,1])
        subplot(2,3,2)
        imshow(g,[0,1])
        subplot(2,3,3)
        imshow(b,[0,1])
    end
end
