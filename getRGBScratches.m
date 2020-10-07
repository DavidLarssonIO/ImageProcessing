function idx = getRGBScratches(rgb,red_bound,green_bound,blue_bound,show_pic)
    r1 = rgb(:,:,1)>=red_bound(1);
    r2 = rgb(:,:,1)<=red_bound(2);
    r = logical(r1.*r2);
    g1 = rgb(:,:,2)>=green_bound(1);
    g2 = rgb(:,:,2)<=green_bound(2);
    g = logical(g1.*g2);
    b1 = rgb(:,:,3)>=blue_bound(1);
    b2 = rgb(:,:,3)<=blue_bound(2);
    b = logical(b1.*b2);
    idx = logical(r.*g.*b);
    if show_pic
        figure,clf
        subplot(2,3,4:6)
        imshow(rgb(:,:))
        subplot(2,3,1)
        imshow(r,[0,1])
        subplot(2,3,2)
        imshow(g,[0,1])
        subplot(2,3,3)
        imshow(b,[0,1])
    end
end

