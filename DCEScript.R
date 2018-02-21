# script for mlogit 

#Read in the data
library(foreign)
clogit = read.csv("DCEFinal.csv")

#Check dats was input successfully

summary(clogit)
str(clogit)
head(clogit)

#read in the mlogit package
library(mlogit)

#Set up choice variablefor mlogit

#Choice variable repeats every 3 times for 317 participants 
#Labeled 1 = Package A, 2 = Package B & C = Current Situation

clogit$choice.ids<- factor(rep(1:3,317),
	labels=c("Package A","Package B","Current Situation"))

#Account for the repeated observations 

clogit$indivs<-factor(rep(1:317, each=42))

#Set-up mlogit data structure

#clogit = defined dataset (remember it is case sensitive)
#choice=Choice variable from the DCEFinal dataset
#alt.var=Alternative Choice IDs that we set-up
#id.var=the number of individual choice sets 


CLOGIT<-mlogit.data(clogit, shape="long", choice="Choice", alt.var="choice.ids", id.var="indivs")

#inspect your data

head(index(CLOGIT),100)

#Standard Logit Test

res1<-mlogit(Choice~train_ind+train_blend+train_grp+feedsupp_vgrp+feedsupp_grp+feedsupp_one+tech_phone+tech_comp+recog_supvr+recog_conf+recog_cert+time_5+time_10+time_15, data=CLOGIT)
summary(res1)