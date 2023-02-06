clc;
clear;
close all;
group = 'ASD';
subject_no = '0';
raw_filename = strcat('raw_data_',group,'_',subject_no,'.csv');
subject = readmatrix(raw_filename);
%roi_curr_idx = 1;
subject(1,:) = [];
subject(:,1) = [];

%roi_curr = subject(roi_curr_idx,:);
%[mean, std_dev] = normfit(roi_curr);

correlations_filename = strcat('correlations_',group,'_',subject_no,'.csv');
correlations = readmatrix(correlations_filename);
correlations(1,:) = [];
correlations(:,1) = [];

tempmax = 0.99999999;
tempmin = -1;
% orderlength = 5;
% for order = 1:orderlength
max = -1;
min = 1;
for i = 1:392
    for j = 1:392
        k = correlations(i,j);
        if k < tempmax
            if k > max
                max = k;
                maxi = i;
                maxj = j;
            end
        end

        if k > tempmin
            if k < min
                min = k;
                mini = i;
                minj = j;
            end
        end
    end
end
corr = max;
i = maxi;
j = maxj;
roi_i = subject(i,:);
roi_j = subject(j,:);
createfigure_old(roi_i, roi_j)

i_series = subject(i,:);
j_series = subject(j,:);

len = size(i_series);
% gauss_window = [1, 1, 1, 1];

variable_win_len = [2, 4, 8, 16, 32, 64];
close all;

for winlen= 1:length(variable_win_len)

    win_size = variable_win_len(winlen);
%     gauss_window = [1];
%     for c=1:win_size-1
%         gauss_window = [gauss_window, 1];
%     end

    gauss_window = transpose(gausswin(win_size));
    
    correlation_strength = [];
    for iter = 1:(len(2) - win_size + 1)
        temp_iseries = i_series(iter:iter+win_size-1) .* gauss_window;
        temp_jseries = j_series(iter:iter+win_size-1) .* gauss_window;
        temp = corrcoef(temp_iseries, temp_jseries);
        correlation_strength = [correlation_strength, temp(1,2)]; %#ok<AGROW> 
    end

    titlename = strcat("Correlation: ",string(corr),"; Gauss Window size: ",string(win_size),"; Group: ",group,"; Subject: ",string(subject_no));
    createfigure_of_GaussWin(correlation_strength, titlename)  

    cd 'Data for Analysis'\'Gaussian Strength'

    foldername = strcat("Subject_",group,'_',subject_no, "_Corr ",string(corr));
    if ~exist(foldername, 'dir')
           mkdir(foldername)
    end
    cd(foldername)
    figure_filename = strcat("Gauss Window size ",string(win_size),"; Group ",group,"; Subject ",string(subject_no),".png");
    saveas(gcf, figure_filename)
    cd ..
    cd ..
    cd ..
end

close all;

%Change the "min" or "max" values