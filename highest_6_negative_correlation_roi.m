function high6corrneg = highest_6_negative_correlation_roi(roi, correlation_matrix)
%Returns the highest 6 negatively correlated regions with roi.
%input: the region of interest w.r.t. which highest correlated other brain
%regions are sought.
%output = array of 6 highest correlated brain region w.r.t. roi

tempmin = -1;
min = 1;
high6corrneg = [];
len = length(correlation_matrix);
for k = 1:6
    for i = 1:len
        temp = correlation_matrix(roi, i);
        if temp > tempmin
            if temp < min
                min = temp;
                minidx = i;
            end
        end
    end
    high6corrneg = [high6corrneg, minidx];
    tempmin = min;
    min = 1;
end

return
end