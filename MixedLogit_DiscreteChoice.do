#base level clogit model 
clogit choice asca ascb train feedback tech recognition time, group(obsid)

#testing to ensure asca - ascb = 0
test asca = ascb

#wtp using time as pay variable
wtp time train tech recognition feedback

#standard mixed logit model
mixlogit choice, rand ( train feedback tech recognition time) group (obsid) id (uid)

#setting up alternative specific constants to avoid no within group variance error

gen alt_c_no=alt*choice

gen alt_c_1=(alt_c_no==1)

gen alt_c_2=(alt_c_no==2)

gen alt_c_3=(alt_c_no==3)


#Creating an alternative specific constant for gender

#setting up gender variables

gen gender_altsp1 = gender*alt_c_1

gen gender_altsp2 = gender*alt_c_2

gen gender_altsp3 = gender*alt_c_3

#running mixlogit with alternative specific constant for gender

mixlogit choice gender_altsp1 gender_altsp3, rand ( train feedback tech recognition time) group (obsid) id (uid)


#creating an alternative specific constant for education

gen education_altsp1 = education*alt_c_1

gen education_altsp2 = education*alt_c_2

gen education_altsp3 = education*alt_c_3

#running mixlogit with alternative specific constant for education

mixlogit choice education_altsp1 education_altsp3, rand ( train feedback tech recognition time) group (obsid) id (uid)


#setting up facility variables

gen facility_altsp1 = facility*alt_c_1

gen facility_altsp2 = facility*alt_c_2

gen facility_altsp3 = facility*alt_c_3

#running mixlogit with alternative specific constant for facility

mixlogit choice facility_altsp1 facility_altsp3, rand ( train feedback tech recognition time) group (obsid) id (uid)


#setting up surveylevel variables

gen surveylevel_altsp1 = surveylevel*alt_c_1

gen surveylevel_altsp2 = surveylevel*alt_c_2

gen surveylevel_altsp3 = surveylevel*alt_c_3

#running mixlogit with alternative specific constant for surveylevel

mixlogit choice surveylevel_altsp1 surveylevel_altsp3, rand ( train feedback tech recognition time) group (obsid) id (uid)


#Testing the significance of variables based on specific lower-level attributes

#Look to see if there is a difference in the importance of the variables time, recognition, feedback, train and tech between males and females

gen malechoice = choice if gender ==1
gen femalechoice = choice if gender ==2

mixlogit malechoice, rand ( train feedback tech recognition time) group (obsid) id (uid)

mixlogit femalechoice, rand ( train feedback tech recognition time) group (obsid) id (uid)

#Check to see preferences in lower level attributes (for example, what females/males preferred to choose in recognition; supervisor, certificate, conferences)

tab malechoice recognition
tab femalechoice recognition



#Look to see if there is a difference in the importance of the variables time, recognition, feedback, train and tech between education levels 1 to 6

gen ed1choice = choice if education ==1
gen ed2choice = choice if education ==2
gen ed3choice = choice if education ==3
gen ed4choice = choice if education ==4
gen ed5choice = choice if education ==5
gen ed6choice = choice if education ==6

mixlogit ed1choice, rand ( train feedback tech recognition time) group (obsid) id (uid)

mixlogit ed2choice, rand ( train feedback tech recognition time) group (obsid) id (uid)

mixlogit ed3choice, rand ( train feedback tech recognition time) group (obsid) id (uid)

mixlogit ed4choice, rand ( train feedback tech recognition time) group (obsid) id (uid)

mixlogit ed5choice, rand ( train feedback tech recognition time) group (obsid) id (uid)

mixlogit ed6choice, rand ( train feedback tech recognition time) group (obsid) id (uid)

#Look to see if there is a difference in the importance of the variables time, recognition, feedback, train and tech between survey levels 1 2 3

gen surveylevel1choice = choice if surveylevel ==1
gen surveylevel2choice = choice if surveylevel ==2
gen surveylevel3choice = choice if surveylevel ==3

mixlogit surveylevel1choice, rand ( train feedback tech recognition time) group (obsid) id (uid)

mixlogit surveylevel2choice, rand ( train feedback tech recognition time) group (obsid) id (uid)

mixlogit surveylevel3choice, rand ( train feedback tech recognition time) group (obsid) id (uid)


#using the base mixedlogit model start looking at the significance of lower level variables for train, feedback, tech, recognition, time

#checking the preference of group training over individual and blended 
mixlogit choice, rand ( train_ind train_blend feedback tech recognition time) group (obsid) id (uid)

#checking the preference of supervisor recognition to conferences and certificates 
mixlogit choice, rand ( train feedback tech recog_conf recog_cert time) group (obsid) id (uid)


