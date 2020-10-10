function idx = getCMYKScratches(rgb,cyan_bound, magenta_bound, yellow_bound, k_bound,show_pic)
% GETCMYKSCRATCHES   Detect scratches in RGB image (rgb) from specified
% thresholds by converting to CMYK color space.
%
%   INPUTS
%       rgb: RGB image to analyze
%       cyan_bound: interval of intensity of cyan color layer to be analyzed
%           (values between 0 and 255)
%       magenta_bound: interval of intensity of magenta color layer to be
%           analyzed (values between 0 and 255)
%       yellow_bound: interval of intensity of yellow color layer to be
%           analyzed (values between 0 and 255)
%       k_bound: interval of intensity of black color layer to be analyzed
%           (values between 0 and 255)
%       show_pic: boolean representing if to display the (enhanced) images
%           and the detected scratches or not
%   RETURNS
%       idx: binary matrix of the same size as the original image where 1
%           represents a scratch and 0 represents no scratch


%   Convert RGB image to  CMYK image
    cform = makecform('srgb2cmyk');
    cmyk = applycform(rgb, cform);
    
%   Enhance contrast of image using histogram equalization
    cmyk = histeq(cmyk);

    cyan = cmyk(:,:,1);
    magenta = cmyk(:,:,2);
    yellow = cmyk(:,:,3);
    black = cmyk(:,:,4);

%   Create binary matrices for each color layer where the intensity is in
%   the corresponding specified interval from input cyan_bound,
%   magenta_bound, cyan_bound and k_bound. The binary matrices are called
%   c, m, y and k
    c1 = cyan>=cyan_bound(1);
    c2 = cyan<=cyan_bound(2);
    c = logical(c1.*c2);
    m1 = magenta>=magenta_bound(1);
    m2 = magenta<=magenta_bound(2);
    m = logical(m1.*m2);
    y1 = yellow>=yellow_bound(1);
    y2 = yellow<=yellow_bound(2);
    y = logical(y1.*y2);    
    k1 = black>=k_bound(1);
    k2 = black<=k_bound(2);
    k = logical(k1.*k2);
    
%   Create a binary matrix where the intensity is in the threshold
%   interval in all four color layers
    idx = logical(c.*m.*y.*k);
    
%   If input show_pic is true: display each enhanced image cyan, magenta,
%   ýellow and black and corresponding binary matrix (c, m, y and k)
%   were scratches have been detected
    if show_pic
        figure,clf
        subplot(2,4,5)
        imshow(cyan)
        subplot(2,4,6)
        imshow(magenta)
        subplot(2,4,7)
        imshow(yellow)
        subplot(2,4,8)
        imshow(black)
        subplot(2,4,1)
        imshow(c,[0,1])
        subplot(2,4,2)
        imshow(m,[0 1])
        subplot(2,4,3)
        imshow(y,[0,1])
        subplot(2,4,4)
        imshow(k,[0,1])
    end
end