# script for mlogit - Base Case - DCEBCS (Discrete Choice Experietn Base Case Scenario)

#Read in the data
library(foreign)
bmlogit = read.csv("DCEBCS.csv")

#Check data was input successfully

#summary will read in your data and give you Min-Max-Mean-Median for each variable
summary(bmlogit)
#str will provide you with a data frame, showing total observations, variables and a detail of each one
str(bmlogit)
#head will give you a sample set of the data
head(bmlogit)

#read in the mlogit package
library(mlogit)

#Set up choice variablefor mlogit

#Choice variable repeats every 3 times for 317 participants 
#Alt variables are as follows:Labeled 1 = Current Situation, 2 = Package B & 3 = Package A

bmlogit$choice.ids<- factor(rep(1:3,317),
	labels=c("Current Situation","Package B","Package A"))

#Account for the repeated observations (each participant had 14 choice sets * 3 alternatives)

bmlogit$indivs<-factor(rep(1:317, each=42))

#Set-up mlogit data structure

#bmlogit = defined dataset (remember it is case sensitive and is base model logit)
#choice=choice variable from the DCEFinal dataset
#alt.var=Alternative Choice IDs that we set-up
#id.var=the number of individual choice sets 

#mlogit.data=evaluating formula | shape: Long = alt.var separated on individual rows, choice alt.var and id.var were set up above
BMLOGIT<-mlogit.data(bmlogit, shape="long", choice="Choice", alt.var="choice.ids", id.var="indivs")

#inspect your data

#sample dataset of the first 50 rows
head(index(BMLOGIT),50)

#Standard Logit Test

bmres<-mlogit(Choice~train_ind+train_blend+train_grp+feedsupp_vgrp+feedsupp_grp+feedsupp_one+tech_phone+tech_comp+recog_supvr+recog_conf+recog_cert+time_5+time_10+time_15, data=BMLOGIT)
summary(bmres)