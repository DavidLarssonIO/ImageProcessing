function idx = getRGBScratchesTest(rgb,red_bound,green_bound,blue_bound,show_pic)
    red = histeq(rgb(:,:,1));
    green = histeq(rgb(:,:,2));
    blue = histeq(rgb(:,:,3));
    r1 = red>=red_bound(1);
    r2 = red<=red_bound(2);
    r = logical(r1.*r2);
    g1 = green>=green_bound(1);
    g2 = green<=green_bound(2);
    g = logical(g1.*g2);
    b1 = blue>=blue_bound(1);
    b2 = blue<=blue_bound(2);
    b = logical(b1.*b2);
    idx = logical(r.*g.*b);
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
