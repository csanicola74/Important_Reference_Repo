/* CREATING OR MODIFYING A VARIABLE */
DATA Example1;
    OldPrice=10;
RUN;

/* I. Creating a Numeric Variable */
DATA Example1;
    SET Example1;
    NewPrice=2*OldPrice;
RUN;

/* can also set up a new dataset too */
DATA Readin;
    SET Example1;
    NewPrice=2*OldPrice;
RUN;

/* II. Creating a Character Variable */
DATA Example1;
    SET Example1;
    Type='Good';
RUN;

/* III. Creating or Modifying a Variable */
DATA Readin;
    SET Example1;
    OldPrice=5 + OldPrice;
    NewPrice=OldPrice*2;
    Change=((NewPrice-OldPrice)/OldPrice);
    Format Change Percent10.0;
RUN;

/* DROPPING VARIABLES FROM A DATA SET IN SAS */
DATA outdata;
    INPUT age gender $ dept obs1 obs2 obs3;
    DATALINES;
1 F 3 17 6 24
1 M 1 19 25 7
3 M 4 24 10 20
3 F 2 19 23 8
2 F 1 14 23 12
2 M 5 1 23 9
3 M 1 8 21 7
1 F 1 7 7 14
3 F 2 2 1 22
1 M 5 20 5 2
3 M 4 21 8 18
1 M 4 7 9 25
2 F 5 10 17 20
3 F 4 21 25 7
3 F 3 9 9 5
3 M 3 7 21 25
2 F 1 1 22 13
2 F 5 20 22 5
;

proc print;
run;

/* I. Scenario: Create a new variable based on existing data and then drop the irrelevant variables */

/* By using the DROP statement, we can command SAS to drop variables only at completion of the DATA step. */
data readin;
    set outdata;
    totalsum=sum(obs1,obs2,obs3);
    drop obs1 obs2 obs3;
run;
/* In the above example, we simply ask SAS sum up all the values in variables obs1,obs2 and obs3 to  */
/* produce a new variable totalsum and then drop the old variables obs1,obs2 and obs3. */

/* II. Drop statement can be used anywhere in DATA setps whereas DROP = option must follow the SET statement */
data readin;
    set outdata;
    if gender='F';
    drop age;
run;

/* OR */
data readin;
    set outdata;
    drop age;
    if gender='F';
run;

/* OR */
data readin;
    set outdata (drop=age);
    if gender='F';
run;

/* III. Scenario: Dropping variables while printing */
proc print data=output (drop=age);
    where gender='F';
run;

/* SAS: HOW TO RENAME VARIABLES */
data mydata (rename=(petallength=petal_length));
    set sashelp.iris;
run;

/* To check if a variable has been renamed correctly, we can use PROC CONTENTS to see the variable names of a dataset. */
proc contents data=sashelp.iris SHORT;

proc contents data=mydata SHORT;

/* renaming a variable name */
data mydata;
    set sashelp.iris (rename=(petallength=petal_length));
    newvar=petal_length * 10;
run;

/* checking names again */
proc contents data=sashelp.iris SHORT;

proc contents data=mydata SHORT;

/* Renaming Multiple Variables in SAS */
data mydata;
    set sashelp.iris (rename=(petallength=petal_length
        sepallength=sepal_length));
run;

proc contents data=sashelp.iris SHORT;

proc contents data=mydata SHORT;

/* Renaming All Variables in SAS */
proc sql noprint;
    select cats(name,"=",name,"_1") into :rename_vars separated by " " from
        dictionary.columns where libname="SASHELP" and memname="IRIS";
quit;

%PUT &rename_vars.;

data mydata;
    set sashelp.iris (rename=(&rename_vars.));
run;

/* Rename Variables based on a Pattern */
proc sql noprint;
    select cats(name,"=",name,"_1") into :rename_vars separated by " " from
        dictionary.columns where libname="SASHELP" and memname="IRIS" and name
        contains 'Length';
quit;

%PUT &rename_vars.;

data mydata;
    set sashelp.iris (rename=(&rename_vars.));
run;
