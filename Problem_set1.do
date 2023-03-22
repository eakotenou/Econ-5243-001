/*******************************************************************************
                      University of Oklahoma
			   PhD. Econometrics II: Problem set 1
			   
			            Emilien Akotenou
						
					Due date: February 3, 2023
********************************************************************************					
                            setting-up
*******************************************************************************/
clear all
cap log close
version 16
macro drop _all
set more off
*==============================================================================*
*                         COLLABORATION ON THE CODE                            *
*------------------------------------------------------------------------------*

* User number
* Me          1   //
* Next User   2  // Replace user 1 by 2 for "global user" before running this
* do on your computer

* Assign the corresponding value to the user currently using this file
global user  1   // change the number to your user number


if $user== 1 { 
    global workdir "/Users/emilienakotenou/Documents/metrics2_data_work" 
}

if $user== 2 {
    global projectfolder " "  // Enter the file path to your projectfolder here
}

*==============================================================================*
*          WORKING DIRECTORIES  & DATA LOADING                    *
*---------------------------------------------------------------------------*
cd"workdir"
e
*cap mkdir "metrics2_data_work" //create metrics2_data_work folder in the directory
global do "metrics2_data_work/do"
global data "metrics2_data_work/data"
global docs "metrics2_data_work/docs"
cap{
    mkdir "metrics2_data_work" 
    mkdir "$do"
	mkdir "$data"
	mkdir "$docs"
}

e
*data loading
cd "$do"
log using "Prolem1_Emilien.smcl", replace
e
					
/*******************************************************************************					
Problem 1: Create a "population" of random observations
*******************************************************************************/
*a)
set seed 1
set obs 10000
gen U = runiform(0,1)
kdensity U
*b-Convert standard uniform random var to standard normal  
	g S = invnormal(U)
	kdensity S
*C
g X = rnormal(15, 5)
*d-
	sum U S X
*e-	
hist X
/*******************************************************************************					
Problem 2: Sampling
*******************************************************************************/
*a)
gen id = _n
order id, first
sort id
save pop
forvalues i 1/6 {
forvalues n 10 50 100 500 1000 5000 {
 egen sample`i'= sample `n', count
 sample`i+1'
 }}
*sample1
preserve	
sample 10, count
save sample_1
restore

*sample2
preserve	
sample 40, count
append using "$data/sample_1"
save sample_2
restore

*sample3
preserve	
sample 50, count 
append using "$data/sample_2"
save sample_3
restore

*sample4
preserve	
sample 400, count
append using "$data/sample_3"
save sample_4
restore

*sample5
preserve	
sample 500, count
append using "$data/sample_4"
save sample_5
restore

*sample6
preserve	
sample 4000, count
append using "$data/sample_5"
save sample_6
restore	

*b) Histogram plot of the differents sample data
cd"$data"
use pop
hist U,bin(30)
hist S,bin(30)
hist X,bin(30)

forvalues n= 1/6 {
use sample_`n'
hist U,bin(30)
hist S,bin(30)
hist X,bin(30)
}

*c)Summary statistics
forvalues n= 1/6 {

use sample_`n'
sum U S X
}
/*******************************************************************************					
Problem 3: 
*******************************************************************************/






