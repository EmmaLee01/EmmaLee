`%notin%` <- Negate(`%in%`)

corp22<-read.csv("C:/Users/Emily/Downloads/OS_ARMED/ArmedServices_04232013_DaytonOH_H_DOD12.csv")
corp24<-read.csv("C:/Users/Emily/Downloads/OS_ARMED/ArmedServices_04232013_DaytonOH_H_DOD14.csv")


sum(corp22$Total[corp22$View=="Democrat"])
sum(corp22$Total[corp22$View=="Republican"])
sum(corp22$Total[corp22$View %notin% c("Democrat","Republican")])







