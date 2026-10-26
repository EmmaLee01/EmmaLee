library(readxl)              #packages needed
library(dplyr)
`%notin%` <- Negate(`%in%`)  
#setwd("C:/Users/Emily/Downloads")

individual<-read.csv("C:/Users/cemiw/Downloads/schedule_a-2026-10-26T00_29_42.csv")         #Replace this with the name of the individual you queried in FEC.gov
mastermerge<-read.csv("cm26.txt",sep = "|")   #Replace this with the name of the Committee master data data for your congressional session
#information: https://www.fec.gov/campaign-finance-data/committee-master-file-description/


colnames(mastermerge)<-c(                     #replacing column names for the committee 
"CMTE_ID",
"CMTE_NM",
"TRES_NM",
"CMTE_ST1",
"CMTE_ST2",
"CMTE_CITY",
"CMTE_ST",
"CMTE_ZIP",
"CMTE_DSGN",
"CMTE_TP",
"CMTE_PTY_AFFILIATION",
"CMTE_FILING_FREQ",
"ORG_TP",
"CONNECTED_ORG_NM",
"CAND_ID")
head(mastermerge)




# making a new data frame (table) to show committee party affiliation
individual2 <- individual %>%
  left_join(mastermerge %>% select(CMTE_ID, CMTE_PTY_AFFILIATION), 
            by = c("committee_id" = "CMTE_ID"))




#below are some functions that show total amounts for donation for each party
sum(individual2$contribution_receipt_amount[individual2$CMTE_PTY_AFFILIATION=="REP"])
sum(individual2$contribution_receipt_amount[individual2$CMTE_PTY_AFFILIATION=="DEM"])


#This is to deal with any parties listed as
individual2[individual2$CMTE_PTY_AFFILIATION %notin% c("DEM","REP")]

sum(individual2$contribution_receipt_amount[individual2$CMTE_PTY_AFFILIATION %notin% c("DEM","REP")])
ncol(individual2[individual2$CMTE_PTY_AFFILIATION %notin% c("DEM","REP")])


length(individual2$contribution_receipt_amount[individual2$CMTE_PTY_AFFILIATION=="REP"])
length(individual2$contribution_receipt_amount[individual2$CMTE_PTY_AFFILIATION == "DEM" & !is.na(individual2$CMTE_PTY_AFFILIATION)])
length(individual2$contribution_receipt_amount[!individual2$CMTE_PTY_AFFILIATION %in% c("DEM", "REP")])

length(individual2$contribution_receipt_amount[!individual2$CMTE_PTY_AFFILIATION %in% c("DEM", "REP")])


nrow(individual2)

length(individual2$contribution_receipt_amount[individual2$contribution_receipt_amount<0])









