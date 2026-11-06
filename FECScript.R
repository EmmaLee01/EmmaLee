library(readxl)              #packages needed
library(dplyr)
`%notin%` <- Negate(`%in%`)  
#setwd("C:/Users/Emily/Downloads")

individual<-read.csv("~/GitHub/EmmaLee/FEC_ARMED/Sankar118.csv")         #Replace this with the name of the individual you queried in FEC.gov
mastermerge<-read.csv("~/GitHub/EmmaLee/FEC_ARMED/cm24.txt",sep = "|")   #Replace this with the name of the Committee master data data for your congressional session
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
#This is to deal with any parties listed as No party 
PACs<-individual2[individual2$CMTE_PTY_AFFILIATION =="NNE",]                                #Typically for company pacs, we can attach a ratio
PACs
sum(PACs$contribution_receipt_amount)


nonpart<-individual2[individual2$CMTE_PTY_AFFILIATION %notin% c("DEM","REP", "NNE"),]       #sometimes these are mistaken, you may want to check these. 
nonpart
sum(nonpart$contribution_receipt_amount)


sum(individual2$contribution_receipt_amount)            #Use this to make sure all contributions add up


#below are the contributions
length(individual2$contribution_receipt_amount[individual2$CMTE_PTY_AFFILIATION=="REP"]) 
length(individual2$contribution_receipt_amount[individual2$CMTE_PTY_AFFILIATION == "DEM" & !is.na(individual2$CMTE_PTY_AFFILIATION)])
length(individual2$contribution_receipt_amount[!individual2$CMTE_PTY_AFFILIATION %in% c("DEM", "REP")])


nrow(individual2) #sum of the lengths should be the same as the contributions


#subtract negative contributions, don't multiply it by 2 because still shows intent.  
length(individual2$contribution_receipt_amount[individual2$contribution_receipt_amount<0])









