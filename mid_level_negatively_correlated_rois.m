function [ith, jth, corr_coeff] = mid_level_negatively_correlated_rois(correlation_matrix)
%mid level (~0.6) positively correlated brain regions i and j of subject with given
%correlation_matrix.
%input: correlation matrix.
%output: ith region, jth region and their correaltion coefficient

temp_corrneg = 1;
for i = 1:392
    for j = 1:392
        k = correlations(i,j);
        if k < 0
            medium_corr = abs(0.6 + k);
            if medium_corr < temp_corrneg
                corrneg = k;
                temp_corrneg = medium_corr; 
                corr_neg_i = i;
                corr_neg_j = j;
            end
        end
    end
end

corr_coeff = corrneg;
ith = corr_neg_i;
jth = corr_neg_j;

return

end