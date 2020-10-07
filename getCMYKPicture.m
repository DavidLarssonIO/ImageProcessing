function idx = getCMYKPicture(rgb,cyan_bound, magenta_bound, yellow_bound, k_bound,show_pic)
    cform = makecform('srgb2cmyk');
    cmyk = applycform(rgb, cform);
    c1 = cmyk(:,:,1)>=cyan_bound(1);
    c2 = cmyk(:,:,1)<=cyan_bound(2);
    c = logical(c1+c2);
    m1 = cmyk(:,:,2)>=magenta_bound(1);
    m2 = cmyk(:,:,2)<=magenta_bound(2);
    m = logical(m1+m2);
    y1 = cmyk(:,:,3)>=yellow_bound(1);
    y2 = cmyk(:,:,3)<=yellow_bound(2);
    y = logical(y1+y2);    
    k1 = cmyk(:,:,4)>=k_bound(1);
    k2 = cmyk(:,:,4)<=k_bound(2);
    k = logical(k1+k2);
    idx = logical((c+m+y+k)>=1);
    
    if show_pic
        figure,clf
        subplot(2,4,5:8)
        imshow(cmyk(:,:))
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