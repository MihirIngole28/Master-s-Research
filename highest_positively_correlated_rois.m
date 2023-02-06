function [ith, jth, corr_coeff] = highest_positively_correlated_rois(correlation_matrix)
%highest positively correlated brain regions i and j of subject with given
%correlation_matrix.
%input: correlation matrix.
%output: ith region, jth region and their correaltion coefficient

tempmax = 0.99999999;
max = -1;
for i = 1:392
    for j = 1:392
        k = correlation_matrix(i,j);
        if k < tempmax
            if k > max
                max = k;
                maxi = i;
                maxj = j;
            end
        end
    end
end

corr_coeff = max;
ith = maxi;
jth = maxj;

return

end