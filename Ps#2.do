/*******************************************************************************
                      University of Oklahoma
			   PhD. Econometrics II: Problem set 2
			   
			            Emilien Akotenou
						
					Due date: February 21, 2023
********************************************************************************					
                            setting-up
*******************************************************************************/
clear all
cap log close
version 16
set more off
*==============================================================================*
*          WORKING DIRECTORIES  & DATA LOADING                                 *
*------------------------------------------------------------------------------*
global workdir "/Users/emilienakotenou/Documents/metrics2_data_work"
cd "$workdir"

global do "$workdir/do"
global docs "$workdir/docs"
cap{
    mkdir "$do"
	mkdir "$docs"
}

**Package
ssc install asdoc
ssc install outreg2
*data loading
log using "$do/Prolem2_Emilien.smcl", replace			
/*******************************************************************************					
Problem 2: Law of itereted expectation in stata
*******************************************************************************/
*a)
set seed 1
set obs 1000
gen X = rnormal(5,1)
gen U = rnormal(0,1)
gen Y = X + U
asdoc sum Y X U
dis r(mean)
reg Y X
outreg2 using mreg.doc, replace

*E[Y\X]= prey
quietly reg Y X
predict prey
predict errorterm, r

sum prey
dis r(mean)

* E[Y]= E[E[Y\X]] = 4.9911352


log close



