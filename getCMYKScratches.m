function idx = getCMYKScratches(rgb,cyan_bound, magenta_bound, yellow_bound, k_bound,show_pic)
    cform = makecform('srgb2cmyk');
    cmyk = applycform(rgb, cform);
    cyan = histeq(cmyk(:,:,1));
    magenta = histeq(cmyk(:,:,2));
    yellow = histeq(cmyk(:,:,3));
    black = histeq(cmyk(:,:,4));
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
    idx = logical(c.*m.*y.*k);
    
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