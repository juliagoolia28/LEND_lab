
## This is the script for merging and analyzing data after adding sub sllip_061 and sllip_064


# rm(list=ls())


# -------------------------------------
library(dplyr);
library(tidyverse);
library(stats);
library(psych);
library(ggpubr);
library(tableone);


## Import datasets
assessmt <- read.csv('sllip_ast_data_redcap.csv')
langinpt <- read.csv('smr_N44.csv')
mri_zamp1 <- read.csv('merge_all5_parcels.csv')
mri_zamp2 <- read.csv('structure_and_random_w_rest.csv')


## -------------------------merge data---------------------

# merge assessments and input data
merge_behav=merge(assessmt,langinpt,by='record_id', all=TRUE, sort=TRUE,suffixes = c(".sllip",".smr"))
#merge_behav=merge(assessmt,langinpt,by=intersect(names(assessmt), names(langinpt)), all=TRUE, sort=TRUE,suffixes = c(".sllip",".smr"))


# merge mri data: structure vs random; structure vs rest; random vs rest
nrow(mri_zamp1)
row_odd_even <- seq_len(nrow(mri_zamp1)) %% 2    ###10101010101
mri_zamp1_row_odd <- mri_zamp1[row_odd_even == 1, ]
mri_zamp1_row_even<- mri_zamp1[row_odd_even == 0, ]
mri_zamp1_5parcels_ind=merge(mri_zamp1_row_odd,mri_zamp1_row_even,by='subject_ID',all=TRUE,sort=TRUE, suffixes = c("_zstats1_rand_large","_zstats2_struc_large"))


nrow(mri_zamp2)
row_odd_even <- seq_len(nrow(mri_zamp2)) %% 2    ###10101010101
mri_zamp2_row_odd <- mri_zamp2[row_odd_even == 1, ]
mri_zamp2_row_even<- mri_zamp2[row_odd_even == 0, ]
mri_zamp2_5parcels_ind=merge(mri_zamp2_row_odd,mri_zamp2_row_even,by='subject_ID',all=TRUE,sort=TRUE, suffixes = c("_cope2","_zstats2"))


merge_mri=merge(mri_zamp1_5parcels_ind,mri_zamp2_5parcels_ind,by='subject_ID', all=TRUE, sort=TRUE,suffixes = c("_diff","_wrest"))

# merge mri and behav
merge_mri_behav=merge(merge_behav,merge_mri,by='subject_ID', all=TRUE, sort=TRUE,suffixes = c("_behav","_mri"))

## ---------------------z score---------------------------------

merge_mri_behav$Child.MLU_z <-as.numeric(scale(merge_mri_behav$Child.MLU))
merge_mri_behav$Parent.MLU_z <- as.numeric(scale(merge_mri_behav$Parent.MLU))
merge_mri_behav$Child.NTW_z <- as.numeric(scale(merge_mri_behav$Child.NTW))
merge_mri_behav$Parent.NTW_z <- as.numeric(scale(merge_mri_behav$Parent.NTW))
merge_mri_behav$Child.NDW_z <- as.numeric(scale(merge_mri_behav$Child.NDW))
merge_mri_behav$Parent.NDW_z <- as.numeric(scale(merge_mri_behav$Parent.NDW))

merge_mri_behav$ctopp_nwr_raw_score_z <- as.numeric(scale(merge_mri_behav$ctopp_nwr_raw_score))
# merge_mri_behav$ctopp_nwr_scaled_z <- as.numeric(scale(merge_mri_behav$ctopp_nwr_scaled))
# merge_mri_behav$ctopp_nwr_percent_z <- as.numeric(scale(merge_mri_behav$ctopp_nwr_percent))

merge_mri_behav$chrono_age_z <- as.numeric(scale(merge_mri_behav$chrono_age))
merge_mri_behav$Child.utterances_z <- as.numeric(scale(merge_mri_behav$Child.utterances))
merge_mri_behav$Parent.utterances_z <- as.numeric(scale(merge_mri_behav$Parent.utterances))


## -----------------select subjects---------------------------

# rename columns for subject flirting 
merge_mri_behav$subject_ID_numb<-str_remove(merge_mri_behav$subject_ID, "sllip_")
merge_mri_behav$subject_ID_numb<-as.numeric(merge_mri_behav$subject_ID_numb)


# Select subjects that have mri data: c(1,2,5,6,7,8,9,11,12,13,14,16,23,25,26,27,29,30,37,38,39,46,47,49,50,51,54,60,61,64)
merge_mri_behav <- merge_mri_behav[merge_mri_behav$subject_ID_numb %in% c(1,2,5,6,7,8,9,11,12,13,14,16,23,25,26,27,29,30,37,38,39,46,47,49,50,51,54,60,61,64), ]
# Drop subjects that have mri data but NOT have language input data
merge_mri_behav <- merge_mri_behav[merge_mri_behav$subject_ID_numb != 1, ]
merge_mri_behav <- merge_mri_behav[merge_mri_behav$subject_ID_numb != 12, ]

# why this cannot: aaaa <- merge_mri_behav[merge_mri_behav$subject_ID_numb ==c(1,2,5,6,7,8,9,11,12,13,14,16,23,25,26,27,29,30,37,38,39,46,47,49,50,51,54,60,61,64), ]  
# why this cannot: merge_mri_behav <- merge_mri_behav[merge_mri_behav$subject_ID_numb != c(1,12), ]

write.csv(merge_mri_behav,"merge_mri_behav_28subjects.csv",row.names = FALSE)

merge_mri_behav <- read.csv('merge_mri_behav_28subjects.csv')
## -----------------------DATA ANALYSIS------------------------------


# language input: Child.MLU, Parent.MLU; Child.NTW, Parent.NTW; Child.NDW, Parent.NDW
# covariate: chrono_age,Child.utterances, Parent.utterances
# CTOPP: ctopp_nwr_raw_score (ctopp_nwr_scaled, ctopp_nwr_percent)


## ----------------partial correlation analysis----------------

#correlation with all behavioral data
#par.r.input<-partial.r(merge_behav, x=c('Child.MLU', 'Parent.MLU', 'Child.NTW','Parent.NTW', 'Child.NDW','Parent.NDW','ctopp_nwr_raw_score'), y=c("chrono_age","Parent.utterances","Child.utterances"))
#lowerMat(par.r.input)
#summary(lm(merge_behav$ctopp_nwr_raw_score_z ~ merge_behav$chrono_age_z + merge_behav$Parent.NTW_z))


# correlation with behavioral data that also has mri data: 28 subjects
par.r.input<-partial.r(merge_mri_behav, x=c('Child.MLU', 'Parent.MLU', 'Child.NTW','Parent.NTW', 'Child.NDW','Parent.NDW','ctopp_nwr_raw_score'), y=c("chrono_age","Parent.utterances","Child.utterances"))
lowerMat(par.r.input)
summary(lm(merge_mri_behav$ctopp_nwr_raw_score_z ~ merge_mri_behav$chrono_age_z + merge_mri_behav$Parent.NTW_z))

# Other method??????
# install.packages("ppcor")
# library(ppcor)
# install.packages("MASS")
# library(MASS)
# pcor.test(list(merge_mri_behav$Child.MLU, merge_mri_behav$Parent.MLU, merge_mri_behav$Child.NTW,merge_mri_behav$Parent.NTW),list(merge_mri_behav$Child.MLU, merge_mri_behav$Parent.MLU, merge_mri_behav$Child.NTW,merge_mri_behav$Parent.NTW),list(merge_mri_behav$chrono_age,merge_mri_behav$Parent.utterances,merge_mri_behav$Child.utterances))

#------------- one sample t test --------------------------

# zstats2: structure>random
t.test(merge_mri_behav$mean_parcel1_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel1_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel2_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel2_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel3_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel3_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel4_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel4_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel5_zstats2_struc_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel5_zstats2_struc_large,mu = 0,alternative = "two.sided")

# zstats1: random >structure
t.test(merge_mri_behav$mean_parcel1_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel1_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel2_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel2_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel3_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel3_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel4_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel4_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel5_zstats1_rand_large,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel5_zstats1_rand_large,mu = 0,alternative = "two.sided")


## zstats2: structure>rest

t.test(merge_mri_behav$mean_parcel1_structwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel1_structwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel2_structwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel2_structwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel3_structwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel3_structwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel4_structwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel4_structwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel5_structwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel5_structwrest_zstats2,mu = 0,alternative = "two.sided")

# zstats2: random>rest
t.test(merge_mri_behav$mean_parcel1_randmwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel1_randmwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel2_randmwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel2_randmwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel3_randmwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel3_randmwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel4_randmwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel4_randmwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$mean_parcel5_randmwrest_zstats2,mu = 0,alternative = "two.sided")
t.test(merge_mri_behav$median_parcel5_randmwrest_zstats2,mu = 0,alternative = "two.sided")

#----------- two sample t-test  ------------------
# mean
t.test(merge_mri_behav$mean_parcel1_structwrest_zstats2,
       merge_mri_behav$mean_parcel1_randmwrest_zstats2,
       alternative="two.sided",
       paired = TRUE,
       var.equal = FALSE
)

t.test(merge_mri_behav$mean_parcel2_structwrest_zstats2,
       merge_mri_behav$mean_parcel2_randmwrest_zstats2,
       alternative="two.sided",
       paired = TRUE,
       var.equal = FALSE
)

t.test(merge_mri_behav$mean_parcel3_structwrest_zstats2,
       merge_mri_behav$mean_parcel3_randmwrest_zstats2,
       alternative="two.sided",
       paired = TRUE,
       var.equal = FALSE
)

t.test(merge_mri_behav$mean_parcel4_structwrest_zstats2,
       merge_mri_behav$mean_parcel4_randmwrest_zstats2,
       alternative="two.sided",
       paired = TRUE,
       var.equal = FALSE
)

t.test(merge_mri_behav$mean_parcel5_structwrest_zstats2,
       merge_mri_behav$mean_parcel5_randmwrest_zstats2,
       alternative="two.sided",
       paired = TRUE,
       var.equal = FALSE
)

# median
t.test(merge_mri_behav$median_parcel1_structwrest_zstats2,
       merge_mri_behav$median_parcel1_randmwrest_zstats2,
       alternative="two.sided",
       paired = TRUE,
       var.equal = FALSE
)

t.test(merge_mri_behav$median_parcel2_structwrest_zstats2,
       merge_mri_behav$median_parcel2_randmwrest_zstats2,
       alternative="two.sided",
       paired = TRUE,
       var.equal = FALSE
)

t.test(merge_mri_behav$median_parcel3_structwrest_zstats2,
       merge_mri_behav$median_parcel3_randmwrest_zstats2,
       alternative="two.sided",
       paired = TRUE,
       var.equal = FALSE
)

t.test(merge_mri_behav$median_parcel4_structwrest_zstats2,
       merge_mri_behav$median_parcel4_randmwrest_zstats2,
       alternative="two.sided",
       paired = TRUE,
       var.equal = FALSE
)

t.test(merge_mri_behav$median_parcel5_structwrest_zstats2,
       merge_mri_behav$median_parcel5_randmwrest_zstats2,
       alternative="two.sided",
       paired = TRUE,
       var.equal = FALSE
)
