library(dplyr)
library(stringr)
library(lubridate)
judiciary<-read.csv("C:/Users/cemiw/Downloads/EmmaLee/Judiciary_merged(witnessdata).csv")

colnames(judiciary)
unique(judiciary$hearingID)


judiciary$datepull <- str_extract(judiciary$hearingID, "[0-9]{8}")
judiciary$lubridated <- mdy(judiciary$datepull)
judiciary$location <- gsub("^.*_[0-9]{8}_([A-Za-z]+)_.*$", "\\1", judiciary$hearingID)

judiciary[judiciary$witness_name== "Mr. Don Sharp",]

#write.csv(judiciary, "judiciaryedit.csv", row.names = F)


