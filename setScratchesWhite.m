function pic = setScratchesWhite(rgb,idx)
    red = rgb(:,:,1);
    green = rgb(:,:,2);
    blue = rgb(:,:,3);
    red(idx) = 255;
    green(idx) = 255;
    blue(idx) = 255;
    pic = cat(3,red,green,blue);
end

