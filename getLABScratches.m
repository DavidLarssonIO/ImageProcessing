function idx = getLABScratches(rgb,lightness_bound,green_to_red_bound,blue_to_yellow_bound,show_pic)
    cform = makecform('srgb2lab');
    lab = applycform(rgb, cform);
    lightness = histeq(lab(:,:,1));
    green_to_red = histeq(lab(:,:,2));
    blue_to_yellow = histeq(lab(:,:,3));
    l1 = lightness>=lightness_bound(1);
    l2 = lab(:,:,1)<=lightness_bound(2);
    l = logical(l1.*l2);
    a1 = green_to_red>=green_to_red_bound(1);
    a2 = green_to_red<=green_to_red_bound(2);
    a = logical(a1.*a2);
    b1 = blue_to_yellow>=blue_to_yellow_bound(1);
    b2 = blue_to_yellow<=blue_to_yellow_bound(2);
    b = logical(b1.*b2);
    idx = logical(l.*a.*b);
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

