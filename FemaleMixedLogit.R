# script for mixedlogit - Female Gender

#Read in the data
library(foreign)
gmlogit = read.csv("DCEGF.csv")

#Check dats was input successfully

summary(gflogit)
str(gflogit)
head(gflogit)

#read in the mlogit package
library(mlogit)

#Set up choice variablefor mlogit

#Choice variable repeats every 3 times for 154 participants 
#Labeled 1 = Package A, 2 = Package B & C = Current Situation

gflogit$choice.ids<- factor(rep(1:3,154),
	labels=c("Package A","Package B","Current Situation"))

#Account for the repeated observations 

gflogit$indivs<-factor(rep(1:154, each=42))

#Set-up mlogit data structure

#gflogit = defined dataset (remember it is case sensitive)
#choice=choice variable from the DCEGFFinal dataset
#alt.var=Alternative Choice IDs that we set-up
#id.var=the number of individual choice sets 


GFLOGIT<-mlogit.data(gflogit, shape="long", choice="choice", alt.var="choice.ids", id.var="indivs")

#inspect your data

head(index(GFLOGIT),100)

#Standard Logit Test

res2<-mlogit(choice~train_ind+train_blend+train_grp+feedsupp_vgrp+feedsupp_grp+feedsupp_one+tech_phone+tech_comp+recog_supvr+recog_conf+recog_cert+time_5+time_10+time_15, data=GFLOGIT)
summary(res2)