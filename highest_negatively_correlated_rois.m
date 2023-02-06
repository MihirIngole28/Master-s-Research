function [ith, jth, corr_coeff] = highest_negatively_correlated_rois(correlation_matrix)
%highest negatively correlated brain regions i and j of subject with given
%correlation_matrix.
%input: correlation matrix.
%output: ith region, jth region and their correaltion coefficient


tempmin = -1;
min = 1;
for i = 1:392
    for j = 1:392
        k = correlation_matrix(i,j);

        if k > tempmin
            if k < min
                min = k;
                mini = i;
                minj = j;
            end
        end
    end
end

corr_coeff = min;
ith = mini;
jth = minj;

return

end