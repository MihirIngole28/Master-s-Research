function MLC_ivj_connectivity_transfer_analysis(group, subject_no)
    
%     group = 'ASD';
%     subject_no = '0';
    raw_filename = strcat('raw_data_',group,'_',subject_no,'.csv');
    subject = readmatrix(raw_filename);
    subject(1,:) = [];
    subject(:,1) = [];
    
    correlations_filename = strcat('correlations_',group,'_',subject_no,'.csv');
    correlations = readmatrix(correlations_filename);
    correlations(1,:) = [];
    correlations(:,1) = [];
    
    [i, j, corr] = mid_level_positively_correlated_rois(correlations);
    
    %Get the highest 6 positively correlated regions with i.
    high6corrpos_i = highest_6_positive_correlation_roi(i, correlations);
    high6corrneg_i = highest_6_negative_correlation_roi(i, correlations);
    high6corrpos_j = highest_6_positive_correlation_roi(j, correlations);
    high6corrneg_j = highest_6_negative_correlation_roi(j, correlations);
    
    
    % high6corr = [high6corrpos_i; high6corrneg_i; high6corrpos_j; high6corrneg_j];
    
    roi_i = subject(i,:);
    roi_j = subject(j,:);
    % createfigure_old(roi_i, roi_j)
    
    variable_win_len = [16, 24, 32, 48, 56, 64];
    % variable_win_len = [16, 32, 56, 64];
    close all;
    %% 
    for polroi = 1:4
        if polroi == 1
            high6corr = high6corrpos_i;
            polarity = "pos";
            region = "i";
            region_val = i;
            roi = roi_i;
    
        elseif polroi == 2
            high6corr = high6corrneg_i;
            polarity = "neg";
            region = "i";
            region_val = i;
            roi = roi_i;
    
        elseif polroi == 3
            high6corr = high6corrpos_j;
            polarity = "pos";
            region = "j";
            region_val = j;
            roi = roi_j;
    
        elseif polroi == 4
            high6corr = high6corrneg_j;
            polarity = "neg";
            region = "j";
            region_val = j;
            roi = roi_j;
    
        else
            print("Something is wrong.")
        end
    
        for winlen= 1:length(variable_win_len)
            win_size = variable_win_len(winlen);
        
            correlation_strengths_high6 = [];
            for itr = 1: length(high6corr)
                roi_high = subject(high6corr(itr), :);
                temp_highcorr = correlation_strength_using_gaussian_window(roi, roi_high, win_size);
                correlation_strengths_high6 = [correlation_strengths_high6; temp_highcorr];
            end
        
        
            for o = 2:6
                close all;
                figure1 = figure('WindowState','maximized');
                titlename = strcat("i,j corr vs ",region,",",string(o),"-level corr; Gauss Window size: ",string(win_size),"; Group: ",group,"; Subject: ",string(subject_no));
                title(titlename)
                axes1 = axes('Parent',figure1,...
                    'Position',[0.0265625 0.0388768898488121 0.959895833333333 0.917926565874729]);
                hold(axes1,'on');
                plot(correlation_strengths_high6(1,:),'DisplayName', string(correlations(region_val,high6corr(1))),'LineWidth',2);
                plot(correlation_strengths_high6(o,:),'DisplayName', string(correlations(region_val,high6corr(o))),'LineWidth',2);
                title(titlename)
                hold(axes1,'off');
                legend1 = legend(axes1,'show');
                set(legend1,...
                    'Position',[0.0321180537425796 0.0508009336078745 0.0812500018129742 0.108666309012706],...
                    'FontSize',14);
                title(legend1,'Correlations:');
                cd 'Data for Analysis'\'Correlation Strength comparision'\
                foldername = strcat("Subject_",group,'_',subject_no, "_MLC_",region,"_",polarity);
                if ~exist(foldername, 'dir')
                    mkdir(foldername)
                end
                cd(foldername)
        
                regionfoldername = strcat(region,"th-region");
                if ~exist(regionfoldername, 'dir')
                    mkdir(regionfoldername)
                end
                cd(regionfoldername)
        
                if ~exist(polarity, 'dir')
                    mkdir(polarity)
                end
                cd(polarity)
        
                orderfoldername = strcat("i,j vs ",region,",",string(o), "-level", polarity," corr");
                if ~exist(orderfoldername, 'dir')
                    mkdir(orderfoldername)
                end
                cd(orderfoldername)
        
                figure_filename = strcat("Gauss Window size ",string(win_size),";",region,",",string(o), "-level", polarity," corr.png");
                saveas(gcf, figure_filename)
                cd ..
                cd ..
                cd ..
                cd ..
                cd ..
                cd ..
            end
        
        end
    
    end
    
        
    close all;
end