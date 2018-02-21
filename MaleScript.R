# script for mlogit - Looking at the characteristics - Male

#Read in the data
library(foreign)
Malogit = read.csv("DCEEM.csv")

#Check data was input successfully

#summary will read in your data and give you Min-Max-Mean-Median for each variable
summary(Malogit)

#str will provide you with a data frame, showing total observations, variables and a detail of each one
str(Malogit)

#head will give you a sample set of the data
head(Malogit)

#read in the mlogit package
library(mlogit)

#Set up choice variablefor mlogit

#Choice variable repeats every 3 times for163 participants 
#Alt variables are as follows:Labeled 1 = Current Situation, 2 = Package B & 3 = Package A

Malogit$choice.ids<- factor(rep(1:3,163),
	labels=c("Current Situation","Package B","Package A"))

#Account for the repeated observations (each participant had 14 choice sets * 3 alternatives)

Malogit$indivs<-factor(rep(1:163, each=42))

#Set-up mlogit data structure

#bmlogit = defined dataset (remember it is case sensitive and is base model logit)
#choice=choice variable from the DCEFinal dataset
#alt.var=Alternative Choice IDs that we set-up
#id.var=the number of individual choice sets 

#mlogit.data=evaluating formula | shape: Long = alt.var separated on individual rows, choice alt.var and id.var were set up above
MALOGIT<-mlogit.data(Malogit, shape="long", choice="choice", alt.var="choice.ids", id.var="indivs")

#inspect your data

#sample dataset of the first 50 rows
head(index(MALOGIT),50)

#Standard Logit Test

mares<-mlogit(choice~train_ind+train_blend+train_grp+feedsupp_vgrp+feedsupp_grp+feedsupp_one+tech_phone+tech_comp+recog_supvr+recog_conf+recog_cert+time_5+time_10+time_15, data=MALOGIT)
summary(mares)