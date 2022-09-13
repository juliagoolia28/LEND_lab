mri_data=read.csv("merge_all5_parcels.csv")
behav_data=read.csv("merge_data_0830.csv")
merge_mri_behav=merge(behav_data,mri_data,by='subject_ID', all=TRUE, sort=TRUE,suffixes = c(".sllip",".smr"))
write.csv(merge_mri_behav,"merge_mri_behav.csv",row.names = FALSE)