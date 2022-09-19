

sllip_ast_data_redcap<-read.csv("sllip_ast_data_redcap.csv")
smr_N41<-read.csv("smr_N41.csv")


# merge_data_0830=merge(sllip_ast_data_redcap,smr_N41,by='record_id', all=TRUE)
# merge_data_0830=merge(sllip_ast_data_redcap,smr_N41,by='record_id', all=TRUE, sort=TRUE)
# merge_data_0830=merge(sllip_ast_data_redcap,smr_N41,by='record_id', all=TRUE, sort=TRUE,suffixes = c(".sllip",".smr"))
merge_data_0830=merge(sllip_ast_data_redcap,smr_N41,by=intersect(names(sllip_ast_data_redcap), names(smr_N41)), all=TRUE, sort=TRUE,suffixes = c(".sllip",".smr"))

write.csv(merge_data_0830,"merge_behav_data.csv",row.names = FALSE)