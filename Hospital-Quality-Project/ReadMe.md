<center><h2><b>Programming Assignment 3</b></h2></center>

<center><h5>R Programming</h5><center>

<h3><b>Introduction</b><h3>

Download the file ProgAssignment3-data.zip file containing the data for Programming Assignment 3 from
the Coursera web site. Unzip the file in a directory that will serve as your working directory. When you
start up R make sure to change your working directory to the directory where you unzipped the data.

The data for this assignment come from the Hospital Compare web site (http://hospitalcompare.hhs.gov)
run by the U.S. Department of Health and Human Services. The purpose of the web site is to provide data and
information about the quality of care at over 4,000 Medicare-certified hospitals in the U.S. This dataset essentially
covers all major U.S. hospitals. This dataset is used for a variety of purposes, including determining
whether hospitals should be fined for not providing high quality care to patients (see http://goo.gl/jAXFX
for some background on this particular topic).

The data for this assignment come from the Hospital Compare web site (http://hospitalcompare.hhs.gov)
run by the U.S. Department of Health and Human Services. The purpose of the web site is to provide data and
information about the quality of care at over 4,000 Medicare-certified hospitals in the U.S. This dataset essentially
covers all major U.S. hospitals. This dataset is used for a variety of purposes, including determining
whether hospitals should be fined for not providing high quality care to patients (see http://goo.gl/jAXFX
for some background on this particular topic).

-outcome-of-care-measures.csv: Contains information about 30-day mortality and readmission rates
for heart attacks, heart failure, and pneumonia for over 4,000 hospitals.

-hospital-data.csv: Contains information about each hospital.

-Hospital_Revised_Flatfiles.pdf: Descriptions of the variables in each file (i.e the code book).

A description of the variables in each of the files is in the included PDF file named Hospital_Revised_Flatfiles.pdf.
This document contains information about many other files that are not included with this programming
assignment. You will want to focus on the variables for Number 19 (“Outcome of Care Measures.csv”) and
Number 11 (“Hospital Data.csv”). You may find it useful to print out this document (at least the pages for
Tables 19 and 11) to have next to you while you work on this assignment. In particular, the numbers of
the variables for each table indicate column indices in each table (i.e. “Hospital Name” is column 2 in the
outcome-of-care-measures.csv file)

<h3><b>1. Plot the 30-day mortality rates for heart attack</b><h3>

Read the outcome data into R via the read.csv function and look at the first few rows.

> outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

> head(outcome)

There are many columns in this dataset. You can see how many by typing ncol(outcome) (you can see
the number of rows with the nrow function). In addition, you can see the names of each column by typing
names(outcome) (the names are also in the PDF document.

To make a simple histogram of the 30-day death rates from heart attack (column 11 in the outcome dataset),
run.

> outcome[, 11] <- as.numeric(outcome[, 11])

> ## You may get a warning about NAs being introduced; that is okay

> hist(outcome[, 11])

Because we originally read the data in as character (by specifying colClasses = "character" we need to
coerce the column to be numeric. You may get a warning about NAs being introduced but that is okay.

<b>There is nothing to submit for this part.</b>

<h3><b>2. Finding the best hospital in a state</b></h3>

Write a function called best that take two arguments: the 2-character abbreviated name of a state and an
outcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector
with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
be one of “heart attack”, “heart failure”, or “pneumonia”. Hospitals that do not have data on a particular
outcome should be excluded from the set of hospitals when deciding the rankings.

Handling ties. If there is a tie for the best hospital for a given outcome, then the hospital names should
be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals “b”, “c”,
and “f” are tied for best, then hospital “b” should be returned).

The function should use the following template

![screenshot from 2016-12-02 02 02 16](https://cloud.githubusercontent.com/assets/19671929/20811383/79a6f5fc-b833-11e6-98c6-d84b96e9d856.png)

The function should check the validity of its arguments. If an invalid state value is passed to best, the
function should throw an error via the stop function with the exact message “invalid state”. If an invalid
outcome value is passed to best, the function should throw an error via the stop function with the exact
message “invalid outcome”.

Here is some sample output from the function.

![screenshot from 2016-12-02 02 04 03](https://cloud.githubusercontent.com/assets/19671929/20811438/af23a5c2-b833-11e6-93a0-d2815445ba8c.png)

Save your code for this function to a file named best.R.

<h3><b>3. Ranking hospitals by outcome in a state</b></h3>

Write a function called rankhospital that takes three arguments: the 2-character abbreviated name of a
state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
The function reads the outcome-of-care-measures.csv file and returns a character vector with the name
of the hospital that has the ranking specified by the num argument. For example, the call

rankhospital("MD", "heart failure", 5)

would return a character vector containing the name of the hospital with the 5th lowest 30-day death rate
for heart failure. The num argument can take values “best”, “worst”, or an integer indicating the ranking
(smaller numbers are better). If the number given by num is larger than the number of hospitals in that
state, then the function should return NA. Hospitals that do not have data on a particular outcome should
be excluded from the set of hospitals when deciding the rankings.

<b>Handling ties.</b> It may occur that multiple hospitals have the same 30-day mortality rate for a given cause
of death. In those cases ties should be broken by using the hospital name. For example, in Texas (“TX”),
the hospitals with lowest 30-day mortality rate for heart failure are shown here.

![screenshot from 2016-12-02 02 07 10](https://cloud.githubusercontent.com/assets/19671929/20811527/1465ea62-b834-11e6-920a-9fa0949d143c.png)

Note that Cypress Fairbanks Medical Center and Detar Hospital Navarro both have the same 30-day rate
(8.7). However, because Cypress comes before Detar alphabetically, Cypress is ranked number 3 in this
scheme and Detar is ranked number 4. One can use the order function to sort multiple vectors in this
manner (i.e. where one vector is used to break ties in another vector).

The function should use the following template.

![screenshot from 2016-12-02 02 08 24](https://cloud.githubusercontent.com/assets/19671929/20811574/3d6a688e-b834-11e6-99a7-8a92a33f9f32.png)

The function should check the validity of its arguments. If an invalid state value is passed to rankhospital,
the function should throw an error via the stop function with the exact message “invalid state”. If an invalid
outcome value is passed to rankhospital, the function should throw an error via the stop function with
the exact message “invalid outcome”.

Here is some sample output from the function.

![screenshot from 2016-12-02 02 09 39](https://cloud.githubusercontent.com/assets/19671929/20811624/6ab8f13e-b834-11e6-8704-c74c5f3f5c36.png)

Save your code for this function to a file named rankhospital.R

Use the submit script provided to submit your solution to this part. There are 4 tests that need to be passed
for this part of the assignment.

<h3><b>4 Ranking hospitals in all states</b></h3>

Write a function called rankall that takes two arguments: an outcome name (outcome) and a hospital ranking
(num). The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
containing the hospital in each state that has the ranking specified in num. For example the function call
rankall("heart attack", "best") would return a data frame containing the names of the hospitals that
are the best in their respective states for 30-day heart attack death rates. The function should return a value
for every state (some may be NA). The first column in the data frame is named hospital, which contains
the hospital name, and the second column is named state, which contains the 2-character abbreviation for
the state name. Hospitals that do not have data on a particular outcome should be excluded from the set of
hospitals when deciding the rankings.

<b>Handling ties.</b> The rankall function should handle ties in the 30-day mortality rates in the same way
that the rankhospital function handles ties.

The function should use the following template.

![screenshot from 2016-12-02 02 12 17](https://cloud.githubusercontent.com/assets/19671929/20811718/c84a3c54-b834-11e6-973d-9465d24605e3.png)

NOTE: For the purpose of this part of the assignment (and for efficiency), your function should NOT call
the rankhospital function from the previous section.
The function should check the validity of its arguments. If an invalid outcome value is passed to rankall,
the function should throw an error via the stop function with the exact message “invalid outcome”. The num
variable can take values “best”, “worst”, or an integer indicating the ranking (smaller numbers are better).
If the number given by num is larger than the number of hospitals in that state, then the function should
return NA.

Here is some sample output from the function.

![screenshot from 2016-12-02 02 13 48](https://cloud.githubusercontent.com/assets/19671929/20811785/fe323862-b834-11e6-8bdf-0faf0297514a.png)

Save your code for this function to a file named rankall.R.


