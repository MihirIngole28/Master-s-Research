clc;
clear;
close all;

subject = readmatrix('subject.csv');
roi_curr_idx = 1;
subject(1,:) = [];
subject(:,1) = [];

roi_curr = subject(roi_curr_idx,:);

plot(roi_curr)
title("Current ROI")
figure

correlations = readmatrix('correlations.csv');
correlations(1,:) = [];
correlations(:,1) = [];

correlations_roi = correlations(roi_curr_idx,:);

histogram(correlations_roi)
title("Histogram of correlations of current ROI")
figure

highestCorr_idx = find(correlations_roi == max(correlations_roi(correlations_roi > 0.5 & correlations_roi < 0.999)));
lowestCorr_idx = find(correlations_roi == min(correlations_roi));

highestCorr = subject(highestCorr_idx,:);
lowestCorr = subject(lowestCorr_idx,:);


plot(highestCorr)
title("Highest correlated ROI")
figure

plot(lowestCorr)
title("Lowest correlated ROI")
figure

histogram(roi_curr)
title("Histogram of current ROI")
figure

%Creating bins of sequence.
temp1 = roi_curr;
temp1(temp1 >= -10 & temp1 <= 10) = 0;
temp1(temp1 < -10) = -1;
temp1(temp1 > 10) = 1;

temp2 = highestCorr;
temp2(temp2 >= -10 & temp2 <= 10) = 0;
temp2(temp2 < -10) = -1;
temp2(temp2 > 10) = 1;

temp3 = lowestCorr;
temp3(temp3 >= -10 & temp3 <= 10) = 0;
temp3(temp3 < -10) = -1;
temp3(temp3 > 10) = 1;


subplot(1,3,1)
plot(temp2)
title("highestcorr to roi")
subplot(1,3,2)
plot(temp1)
title("roi")
subplot(1,3,3)
plot(temp3)
title("lowestcorr to roi")
sgtitle("Comparing step conversion of roi, highest corr and lowest corr rois")
figure

i = correlations(roi_curr_idx,:);
j = correlations(highestCorr_idx,:);
js_correlated_idx = find(j > 0.1);
indirect_conn_idx = find(i == min(i(js_correlated_idx(i(js_correlated_idx) < -0.1))));
indirect_conn = subject(indirect_conn_idx,:);

temp4 = indirect_conn;
temp4(temp4 >= -10 & temp4 <= 10) = 0;
temp4(temp4 < -10) = -1;
temp4(temp4 > 10) = 1;

subplot(1,3,1)
plot(temp1)
title("ith region")
subplot(1,3,2)
plot(temp2)
title("jth region")
subplot(1,3,3)
plot(temp4)
title("kth region")
sgtitle("Comparing step conversion of ith-roi, jth-roi and kth-roi")
%figure
