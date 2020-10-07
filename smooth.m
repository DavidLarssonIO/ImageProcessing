function I_smooth = smooth(I, I_m)
    I_smooth = I; 

    s = size(I);
        
    n = 6;
    n1 = n+1;
    
    lim_i = int16(s(1)-n);
    lim_j = int16(s(2)-n);

    for j=n1:lim_j
        for i=n1:lim_i  
            if I_m(i,j)~=0
                I_mask = I(i-n:i+n, j-n:j+n);
                I_smooth(i,j) = median(I_mask(I_mask~=0));
            end 
        end
    end

end