

####################################

mri_data=read.csv("merge_all5_parcels.csv")
nrow(mri_data)
row_odd_even <- seq_len(nrow(mri_data)) %% 2    ###10101010101
mri_data_row_odd <- mri_data[row_odd_even == 1, ]
mri_data_row_even<- mri_data[row_odd_even == 0, ]
mri_all5_parcels_ind=merge(mri_data_row_odd,mri_data_row_even,by='subject_ID',all=TRUE,sort=TRUE, suffixes = c("_zstats1_rand_large","_zstats2_struc_large"))

behav_data=read.csv("merge_behav_data.csv")
merge_mri_behav=merge(behav_data,mri_all5_parcels_ind,by='subject_ID', all=FALSE, sort=TRUE,suffixes = c("_behav","_mri"))
write.csv(merge_mri_behav,"merge_mri_behav.csv",row.names = FALSE)






