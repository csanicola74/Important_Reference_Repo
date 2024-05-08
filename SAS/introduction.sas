/* EXAMPLE CODE FOR PRACTICE */
data temp;
    input ID Company $20.;
    cards;
12 Reliance
13 Google
11 Microsoft
10 SAS
9 Tom
10 SAP
;

proc print;
run;
/* ---------------------------------------------------------------------------------------------------------------------- */
/* FILTERING DATA */

/* The IF statement is used to apply a condition to filter the data. */
data out;
    set temp;
    if ID > 10;
run;
/* The SET statement allows you to read values from a SAS data set (temp).  */
/* The SAS Statement 'IF ID > 10' tells SAS to read only those ID values that are greater than 10.  */
/* Later SAS paste these values into a new data set (OUT) without overwriting existing data set (temp) */

/*Multiple Conditions - The following SAS code is using the multiple conditions in the IF statement.*/
data out;
    set temp;
    if ID=10 and Company='SAS';
run;
/* if ID = 10 and Company = 'SAS';: In this case, IF statement selects records where both the "ID" variable is equal to 10 and  */
/* the "Company" variable is equal to 'SAS'. */
/* ---------------------------------------------------------------------------------------------------------------------- */
/* IF-THEN-ELSE Statements */
/* The following code creates a new "flag" variable where the value 'No' is assigned when the "ID" is less than or equal to 10,  */
/* 'Yes' when the "ID" is greater than 10 and less than or equal to 12, and 'Invalid' for any other value of "ID" greater than 12,  */

/* based on the values in the existing dataset "temp". The "flag" variable is a character variable with a length of 8 characters. */
data out;
    set temp;
    length flag $8;
    if ID <=10 then flag='No';
    else if ID > 10 and ID <=12 then flag='Yes';
    else flag='Invalid';
run;

/* ---------------------------------------------------------------------------------------------------------------------- */
/* How to Sort Data in SAS */

/* In SAS, the PROC SORT procedure sorts a dataset. */
proc sort data=temp;
    by ID;
run;
/* by ID;: This line specifies the variable "ID" that will be used for sorting the dataset.  */
/* When you sort the data, the values of the "ID" variable will be arranged in ascending order by default. */

/* To sort the dataset in descending order, you can use the keyword descending after BY statement. */
proc sort data=temp;
    by descending ID;
run;

/* ---------------------------------------------------------------------------------------------------------------------- */
/* How to Calculate Summary in SAS */
/* In SAS, PROC MEANS is used to calculate summary statistics, such as count, mean, minimum, maximum,  */
/* standard deviation and more for one or more variables in a SAS dataset.  */

/* The following code calculates descriptive statistics for the variable "ID" in the dataset "temp." */
proc means data=temp;
    var ID;
run;

/* ---------------------------------------------------------------------------------------------------------------------- */
/* How to Generate Frequency Distribution in SAS */
/* PROC FREQ is a SAS procedure used to generate frequency tables, which display the distribution of values within categorical variables. */
/* The following code shows how to use PROC FREQ with the built-in SAS dataset "sashelp.cars".  */
/* We have created a new dataset named "cars" by copying the content of the built-in dataset "sashelp.cars". */

/* Step 1: Access the sashelp.cars dataset */
data cars;
    set sashelp.cars;
run;

/* Step 2: Use PROC FREQ to analyze the "make" variable */
proc freq data=cars;
    tables make;
run;
/* Within the PROC FREQ step, the "tables" statement is used to specify the variable "make" for which we want to calculate the frequency table.  */
/* In this case, we are interested in analyzing the distribution of the "make" variable, which represents the car manufacturer. */
/* ---------------------------------------------------------------------------------------------------------------------- */
/* How to Combine Datasets in SAS */
/* PROC APPEND is a SAS procedure used to combine or append datasets.  */
/* It is commonly used when you have multiple datasets with the same structure (same variables and data types) and you want to merge them vertically,  */
/* concatenating one dataset below the other. */

/* Create dataset1 */
data dataset1;
    input ID Name $ Age Grade $;
    cards;
1 John 18 A
2 Jane 17 B
3 Alex 19 A
;
run;

/* Create dataset2 */
data dataset2;
    input ID Name $ Age Grade $;
    cards;
4 Sarah 16 B
5 Mike 18 C
6 Emily 17 A
;
run;

/* Use PROC APPEND to combine datasets */
proc append base=dataset1 data=dataset2;
run;
