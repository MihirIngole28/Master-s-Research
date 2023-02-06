clc;
clear;
close all;
group = 'TC';
subject_no = '25';
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
orderlength = 5;
for order = 1:orderlength
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
    roi_maxi = subject(maxi,:);
    roi_maxj = subject(maxj,:);
    createfigure(roi_maxi, roi_maxj, order, max, maxi, maxj)
    cd 'Data for Analysis'\
    foldername = strcat("Subject_",group,'_',subject_no);
    if ~exist(foldername, 'dir')
           mkdir(foldername)
    end
    cd(foldername)
    figure_filename = strcat("Order ", string(order), " Positive correlation.png");
    saveas(gcf, figure_filename)
    cd ..
    cd ..


    roi_mini = subject(mini,:);
    roi_minj = subject(minj,:);
    createfigure(roi_mini, roi_minj, order, min, mini, minj)
    
    cd 'Data for Analysis'\
    foldername = strcat("Subject_",group,'_',subject_no);
    if ~exist(foldername, 'dir')
           mkdir(foldername)
    end
    cd(foldername)
    figure_filename = strcat("Order ", string(order), " Negative correlation.png");
    saveas(gcf, figure_filename)
    cd ..
    cd ..


    tempmax = max;
    tempmin = min;
end
close all;