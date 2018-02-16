# script for mixedlogit - Male Gender

#Read in the data
library(foreign)
gmlogit = read.csv("DCEGM.csv")

#Check dats was input successfully

summary(gmlogit)
str(gmlogit)
head(gmlogit)

#read in the mlogit package
library(mlogit)

#Set up choice variablefor mlogit

#Choice variable repeats every 3 times for 163 participants 
#Labeled 1 = Package A, 2 = Package B & C = Current Situation

gmlogit$choice.ids<- factor(rep(1:3,163),
	labels=c("Package A","Package B","Current Situation"))

#Account for the repeated observations 

gmlogit$indivs<-factor(rep(1:163, each=42))

#Set-up mlogit data structure

#gmlogit = defined dataset (remember it is case sensitive)
#choice=choice variable from the DCEFinal dataset
#alt.var=Alternative Choice IDs that we set-up
#id.var=the number of individual choice sets 


GMLOGIT<-mlogit.data(gmlogit, shape="long", choice="choice", alt.var="choice.ids", id.var="indivs")

#inspect your data

head(index(GMLOGIT),100)

#Standard Logit Test

res1<-mlogit(choice~train_ind+train_blend+train_grp+feedsupp_vgrp+feedsupp_grp+feedsupp_one+tech_phone+tech_comp+recog_supvr+recog_conf+recog_cert+time_5+time_10+time_15, data=GMLOGIT)
summary(res1)