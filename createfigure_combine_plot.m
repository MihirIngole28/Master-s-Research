function createfigure_combine_plot(YMatrix1)
%CREATEFIGURE1(YMatrix1)
%  YMATRIX1:  matrix of plot y data

%  Auto-generated by MATLAB on 04-Feb-2023 14:08:38

% Create figure
figure1 = figure('WindowState','maximized');

% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.0265625 0.0388768898488121 0.959895833333333 0.917926565874729]);
hold(axes1,'on');

% Create multiple line objects using matrix input to plot
plot1 = plot(YMatrix1,'LineWidth',2);
set(plot1(1),'DisplayName','0.82457');
set(plot1(2),'DisplayName','0.78416');

% Create title
title('Combine plots');

hold(axes1,'off');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.0321180537425796 0.0508009336078745 0.0812500018129742 0.108666309012706],...
    'FontSize',14);
title(legend1,'Correlations:');

