clc;
clear;
close all;
group = 'ASD';
subject_no = '0';
raw_filename = strcat('raw_data_',group,'_',subject_no,'.csv');
subject = readmatrix(raw_filename);
subject(1,:) = [];
subject(:,1) = [];

correlations_filename = strcat('correlations_',group,'_',subject_no,'.csv');
correlations = readmatrix(correlations_filename);
correlations(1,:) = [];
correlations(:,1) = [];

[i, j, corr] = highest_positively_correlated_rois(correlations);

roi_i = subject(i,:);
roi_j = subject(j,:);
createfigure_old(roi_i, roi_j)

variable_win_len = [2, 4, 8, 16, 24, 32, 48, 56, 64];
close all;

for winlen= 1:length(variable_win_len)

    win_size = variable_win_len(winlen);

%Below code is for window of 1s [1,1,...,1]. 
% Note: this is not a gaussian window

%     gauss_window = [1];
%     for c=1:win_size-1
%         gauss_window = [gauss_window, 1];
%     end

    correlation_strength = correlation_strength_using_gaussian_window(roi_i, roi_j, win_size);

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
