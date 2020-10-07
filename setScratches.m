function pic = setScratches(rgb,scratches)
    [nx,ny] = size(scratches);
    [row,col] = find(scratches==1);
    idx = find(scratches==1);
    [r,c] = find(scratches == 0);
    % = ind2sub([ny,nx],scratches_ind);
    
    
    scratches_nn = knnsearch([r,c],[row col],'k',1,'IncludeTies',true);
    red = rgb(:,:,1);
    green = rgb(:,:,2);
    blue = rgb(:,:,3);

    for i=1:length(scratches_nn)
        ind = sub2ind(size(scratches),r(scratches_nn{i}),c(scratches_nn{i}));
        red(idx(i)) = floor(mean(red(ind)));
        green(idx(i)) = floor(mean(green(ind)));
        blue(idx(i)) = floor(mean(blue(ind)));
    end
    pic = cat(3,red,green,blue);
end