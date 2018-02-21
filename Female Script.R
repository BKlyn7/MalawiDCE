# script for mlogit - Looking at the characteristics - Female

#Read in the data
library(foreign)
Felogit = read.csv("DCEEF.csv")

#Check data was input successfully

#summary will read in your data and give you Min-Max-Mean-Median for each variable
summary(Felogit)

#str will provide you with a data frame, showing total observations, variables and a detail of each one
str(Felogit)

#head will give you a sample set of the data
head(Felogit)

#read in the mlogit package
library(mlogit)

#Set up choice variablefor mlogit

#Choice variable repeats every 3 times for 154 participants 
#Alt variables are as follows:Labeled 1 = Current Situation, 2 = Package B & 3 = Package A

Felogit$choice.ids<- factor(rep(1:3,154),
	labels=c("Current Situation","Package B","Package A"))

#Account for the repeated observations (each participant had 14 choice sets * 3 alternatives)

Felogit$indivs<-factor(rep(1:154, each=42))

#Set-up mlogit data structure

#Felogit = defined dataset (remember it is case sensitive and is base model logit)
#choice=choice variable from the DCEF dataset
#alt.var=Alternative Choice IDs that we set-up
#id.var=the number of individual choice sets 

#mlogit.data=evaluating formula | shape: Long = alt.var separated on individual rows, choice alt.var and id.var were set up above
FELOGIT<-mlogit.data(Felogit, shape="long", choice="choice", alt.var="choice.ids", id.var="indivs")

#inspect your data

#sample dataset of the first 50 rows
head(index(FELOGIT),50)

#Standard Logit Test

feres<-mlogit(choice~train_ind+train_blend+train_grp+feedsupp_vgrp+feedsupp_grp+feedsupp_one+tech_phone+tech_comp+recog_supvr+recog_conf+recog_cert+time_5+time_10+time_15, data=FELOGIT)
summary(feres)