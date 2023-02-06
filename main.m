subject_groups = ["ASD", "TC"];
subject_ASD = ["0","1","2","3","4"];
subject_TC = ["21","22","23","24","25"];

for grp = 1:2
    if subject_groups(grp) == "ASD"
        for no = 1:length(subject_ASD)
            HC_ivj_connectivity_transfer_analysis(subject_groups(grp),subject_ASD(no));
            MLC_ivj_connectivity_transfer_analysis(subject_groups(grp),subject_ASD(no));
        end
    elseif subject_groups(grp) == "TC"
        for no = 1:length(subject_TC)
            HC_ivj_connectivity_transfer_analysis(subject_groups(grp),subject_TC(no));
            MLC_ivj_connectivity_transfer_analysis(subject_groups(grp),subject_TC(no));
        end
    else
        print("Something is wrong in main.")
    end
end
