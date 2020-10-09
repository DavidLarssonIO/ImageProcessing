function scratch_index = getSchratches(picture_cell,show_pic)
length(picture_cell)
scratch_index = cell(length(picture_cell),1);
for i = 1:length(picture_cell)
    pic = picture_cell{i};
    idx1 = getRGBScratchesTest(pic,[0 200],[0, 255],[0, 255],show_pic);
    idx2 = getCMYKScratches(pic,[20 255],[0, 250],[0, 250],[0, 235],show_pic);
    idx3 = getLABScratches(pic,[0 230],[0 200], [0 255],show_pic);
    idx = logical(idx1.*idx2.*idx3);
    se = strel('square',3);
    idx = imclose(idx,se);
    edge_index = getEdgesDetection(pic);
    edge_index = imclose(edge_index,se);
    scratch_index{i} = logical(idx.*edge_index);
end
end