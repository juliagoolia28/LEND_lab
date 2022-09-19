## data analysis of language input, mri and CTOPP 


# language input: Child.MLU, Parent.MLU; Child.NTW, Parent.NTW; Child.NDW, Parent.NDW
# covariate: participant_age,Child.utterances, Parent.utterances
# CTOPP: ctopp_nwr_raw_score, ctopp_nwr_scaled, ctopp_nwr_percent

# rm(list=ls())
all_data_ind <- read.csv("merge_mri_behav.csv")


#--------------------z score--------------------------
all_data_ind$Child.MLU_z <-as.numeric(scale(all_data_ind$Child.MLU))
all_data_ind$Parent.MLU_z <- as.numeric(scale(all_data_ind$Parent.MLU))
all_data_ind$Child.NTW_z <- as.numeric(scale(all_data_ind$Child.NTW))
all_data_ind$Parent.NTW_z <- as.numeric(scale(all_data_ind$Parent.NTW))
all_data_ind$Child.NDW_z <- as.numeric(scale(all_data_ind$Child.NDW))
all_data_ind$Parent.NDW_z <- as.numeric(scale(all_data_ind$Parent.NDW))

all_data_ind$ctopp_nwr_raw_score_z <- as.numeric(scale(all_data_ind$ctopp_nwr_raw_score))
# all_data_ind$ctopp_nwr_scaled_z <- as.numeric(scale(all_data_ind$ctopp_nwr_scaled))
all_data_ind$ctopp_nwr_percent_z <- as.numeric(scale(all_data_ind$ctopp_nwr_percent))

all_data_ind$participant_age_z <- as.numeric(scale(all_data_ind$participant_age))
all_data_ind$Child.utterances_z <- as.numeric(scale(all_data_ind$Child.utterances))
all_data_ind$Parent.utterances_z <- as.numeric(scale(all_data_ind$Parent.utterances))



#--------------- correlation analysis-----------------------

# cor_matrx <-cor(all_data_ind[, c('participant_age','Child.utterances', 'Parent.utterances','Child.MLU', 'Parent.MLU', 'Child.NTW','Parent.NTW', 'Child.NDW','Parent.NDW','ctopp_nwr_raw_score')])

# the number of participants with age data is small
cor_matrx <-cor(all_data_ind[, c('Child.utterances', 'Parent.utterances','Child.MLU', 'Parent.MLU', 'Child.NTW','Parent.NTW', 'Child.NDW','Parent.NDW','ctopp_nwr_raw_score')])
#cor_matrx_standardized <-cor(all_data_ind[, c('Child.utterances_z', 'Parent.utterances_z','Child.MLU_z', 'Parent.MLU_z', 'Child.NTW_z','Parent.NTW_z', 'Child.NDW_z','Parent.NDW_z','ctopp_nwr_raw_score_z')])



#------------- one sample t test --------------------------

# zstats1: structure>random
t.test(all_data_ind$mean_parcel1_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$median_parcel1_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$mean_parcel2_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$median_parcel2_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$mean_parcel3_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$median_parcel3_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$mean_parcel4_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$median_parcel4_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$mean_parcel5_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$median_parcel5_zstats2_struc_large,mu = 0,alternative = "two.sided")

# zstats1: random >structure
t.test(all_data_ind$mean_parcel1_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$median_parcel1_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$mean_parcel2_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$median_parcel2_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$mean_parcel3_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$median_parcel3_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$mean_parcel4_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$median_parcel4_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$mean_parcel5_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(all_data_ind$median_parcel5_zstats1_rand_large,mu = 0,alternative = "two.sided")
