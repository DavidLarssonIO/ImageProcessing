function I_med = vertical_median(I,n)

I_med = I;
s = size(I);
pad = int16(floor(n/2));
lim_i = int16(s(1)-pad);
lim_j = int16(s(2)-pad);

for i = 1+pad:lim_i
    for j = 1+pad:lim_j
        I_new = I(i-pad:i+pad,j);
        I_med(i,j) = median(I_new(:));
    end 
end

end