# script for mlogit - Multinomial model, looking at factors such as age, survey level, district, facility, gender, health worker cadre, out of school experience, technology access 

#Read in the data
library(foreign)
elogit = read.csv("DCEE.csv")

#Check data was input successfully

#summary will read in your data and give you Min-Max-Mean-Median for each variable
summary(elogit)
#str will provide you with a data frame, showing total observations, variables and a detail of each one
str(elogit)
#head will give you a sample set of the data
head(elogit)

#read in the mlogit package
library(mlogit)

#Set up choice variablefor mlogit

#Choice variable repeats every 3 times for 317 participants 
#Alt variables are as follows:Labeled 1 = Current Situation, 2 = Package B & 3 = Package A

elogit$choice.ids<- factor(rep(1:3,317),
	labels=c("Current Situation","Package B","Package A"))

#Account for the repeated observations (each participant had 14 choice sets * 3 alternatives)

elogit$indivs<-factor(rep(1:317, each=42))

#Set-up mlogit data structure

#elogit = defined dataset (remember it is case sensitive and is base model logit)
#choice=choice variable from the DCEFinal dataset
#alt.var=Alternative Choice IDs that we set-up
#id.var=the number of individual choice sets 

#mlogit.data=evaluating formula | shape: Long = alt.var separated on individual rows, choice alt.var and id.var were set up above
ELOGIT<-mlogit.data(elogit, shape="long", choice="choice", alt.var="choice.ids", id.var="indivs")

#inspect your data

#sample dataset of the first 50 rows
head(index(ELOGIT),50)

#Standard Logit Test

eres<-mlogit(choice~train_ind+train_blend+train_grp+feedsupp_vgrp+feedsupp_grp+feedsupp_one+tech_phone+tech_comp+recog_supvr+recog_conf+recog_cert+time_5+time_10+time_15|agen+survey_level+gender+out_of_school_experience+highest_level+district+facility+health_worker_cadre+computer_access+phone_access+tablet_access, data=ELOGIT)
summary(eres)