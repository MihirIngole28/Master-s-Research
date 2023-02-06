function high6corrpos = highest_6_positive_correlation_roi(roi, correlation_matrix)
%Returns the highest 6 positively correlated regions with roi.
%input: the region of interest w.r.t. which highest correlated other brain
%regions are sought.
%output = array of 6 highest correlated brain region w.r.t. roi

tempmax = 1;
max = -1;
high6corrpos = [];
len = length(correlation_matrix);
for k = 1:6
    for i = 1:len
        temp = correlation_matrix(roi, i);
        if temp < tempmax
            if temp > max
                max = temp;
                maxidx = i;
            end
        end
    end
    high6corrpos = [high6corrpos, maxidx];
    tempmax = max;
    max = -1;
end

return
end