function correlation_strength = correlation_strength_using_gaussian_window(roi_i, roi_j, win_size)
%Input is ith region of interest and jth region of interest.
%Gaussian window size

gauss_window = transpose(gausswin(win_size));

correlation_strength = [];
padded_roi_i = [];
for pad = 1:(win_size/2)
    padded_roi_i = [padded_roi_i, 0];
end

padded_roi_i = [padded_roi_i, roi_i, padded_roi_i];

padded_roi_j = [];
for pad = 1:(win_size/2)
    padded_roi_j = [padded_roi_j, 0];
end

padded_roi_j = [padded_roi_j, roi_j, padded_roi_j];

len = size(padded_roi_i);

for iter = 1:(len(2) - win_size + 1)
    temp_iseries = padded_roi_i(iter:iter+win_size-1) .* gauss_window;
    temp_jseries = padded_roi_j(iter:iter+win_size-1) .* gauss_window;
    temp = corrcoef(temp_iseries, temp_jseries);
    correlation_strength = [correlation_strength, temp(1,2)]; %#ok<AGROW> 
end

return 

end