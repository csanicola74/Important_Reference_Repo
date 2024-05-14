/* Purpose: To summarize and score the measures within the questionnaires. */
/* Data: The combined data from the psych questionnaires in Qualtrics */
/* Important Variables:  */
/* Complex Logic Explanation:  */
/* Parameter and Return Value Descriptions: */
/* References or Links:  */
/* TODOs and FIXMEs:  */
/* Date and Authorship: Created on 5/14/2024 by Caroline Sanicola  */
/* ----------------------------------------------------------------------------------------------------------------------------- */
/* Step 1: Define the library reference where the file will be stored */
libname BARI 'C:\Users\csanicol\OneDrive - stonybrookmedicine\SAS\Datasets';

/* Step 2: Import the Excel file directly into the BARI library */
proc import
    datafile='C:\Users\csanicol\OneDrive - stonybrookmedicine\SAS\Datasets\SAS Ver_5.14.2024.xlsx'
    out=BARI.original_data /* Saving directly into BARI library */ dbms=xlsx
    replace; /* Replace existing dataset if it exists */
run;

/* I. BIS-11 Scoring */

/* Step 1: Print unique values in the BSI-11 Columns */
proc freq data=BARI.original_data;
    tables BSI11_1_1 BSI11_1_2 BSI11_1_3 BSI11_1_4 BSI11_1_5 BSI11_1_6 BSI11_1_7
        BSI11_1_8 BSI11_1_9 BSI11_1_10 BSI11_1_11 BSI11_1_12 BSI11_1_13
        BSI11_1_14 BSI11_1_15 BSI11_1_16 BSI11_1_17 BSI11_1_18 BSI11_1_19
        BSI11_1_20 BSI11_1_21 BSI11_1_22 BSI11_1_23 BSI11_1_24 BSI11_1_25
        BSI11_1_26 BSI11_1_27 BSI11_1_28 BSI11_1_29 BSI11_1_30 / nocum
        nopercent;
run;

/* Step 2a: Recode BSI11_1_1 */
data BARI.data_recoded;
    set BARI.original_data;

    /* Define an array for the columns we are recodding */
    array bsi_to_recode(*) BSI11_1_1 BSI11_1_2 BSI11_1_3 BSI11_1_4 BSI11_1_5
        BSI11_1_6 BSI11_1_7 BSI11_1_8 BSI11_1_9 BSI11_1_10 BSI11_1_11 BSI11_1_12
        BSI11_1_13 BSI11_1_14 BSI11_1_15 BSI11_1_16 BSI11_1_17 BSI11_1_18
        BSI11_1_19 BSI11_1_20 BSI11_1_21 BSI11_1_22 BSI11_1_23 BSI11_1_24
        BSI11_1_25 BSI11_1_26 BSI11_1_27 BSI11_1_28 BSI11_1_29 BSI11_1_30;
    /* Columns to be recoded */
    array bsi_recoded(*) BSI11_1_1_SCORE BSI11_1_2_SCORE BSI11_1_3_SCORE
        BSI11_1_4_SCORE BSI11_1_5_SCORE BSI11_1_6_SCORE BSI11_1_7_SCORE
        BSI11_1_8_SCORE BSI11_1_9_SCORE BSI11_1_10_SCORE BSI11_1_11_SCORE
        BSI11_1_12_SCORE BSI11_1_13_SCORE BSI11_1_14_SCORE BSI11_1_15_SCORE
        BSI11_1_16_SCORE BSI11_1_17_SCORE BSI11_1_18_SCORE BSI11_1_19_SCORE
        BSI11_1_20_SCORE BSI11_1_21_SCORE BSI11_1_22_SCORE BSI11_1_23_SCORE
        BSI11_1_24_SCORE BSI11_1_25_SCORE BSI11_1_26_SCORE BSI11_1_27_SCORE
        BSI11_1_28_SCORE BSI11_1_29_SCORE BSI11_1_30_SCORE;
    /* New Columns made from recoding */
    /* Loop through each element in the array */
    do i=1 to dim(bsi_to_recode);
        /* Apply specific recoding logic */
        if bsi_to_recode(i)='Almost Always/Always4' then bsi_recoded(i)=4;
        else if bsi_to_recode(i)='Never/Rarely1' then bsi_recoded(i)=1;
        else if bsi_to_recode(i)='Occasionally2' then bsi_recoded(i)=2;
        else if bsi_to_recode(i)='Often3' then bsi_recoded(i)=3;
        else bsi_recoded(i)=.; /* For missing or undefined categories */
    end;

    drop i;
    /* Optional: drop the loop index variable from the resulting dataset */
run;

/* Step 2b: Reverse Coding BSI11_1 */
data BARI.data_recoded;
    set BARI.data_recoded;

    /* Define an array for the columns we are recodding */
    array bsi_to_recode_reverse(*) BSI11_1_1_SCORE BSI11_1_7_SCORE
        BSI11_1_8_SCORE BSI11_1_9_SCORE BSI11_1_10_SCORE BSI11_1_11_SCORE
        BSI11_1_12_SCORE BSI11_1_13_SCORE BSI11_1_15_SCORE BSI11_1_20_SCORE
        BSI11_1_29_SCORE BSI11_1_30_SCORE;
    array bsi_reversed_recoded(*) BSI11_1_1_REVERSED BSI11_1_7_REVERSED
        BSI11_1_8_REVERSED BSI11_1_9_REVERSED BSI11_1_10_REVERSED
        BSI11_1_11_REVERSED BSI11_1_12_REVERSED BSI11_1_13_REVERSED
        BSI11_1_15_REVERSED BSI11_1_20_REVERSED BSI11_1_29_REVERSED
        BSI11_1_30_REVERSED;

    /* Loop through each element in the array */
    do i=1 to dim(bsi_reversed_recoded);
        /* Apply specific recoding logic */
        if bsi_to_recode_reverse(i)=4 then bsi_reversed_recoded(i)=1;
        else if bsi_to_recode_reverse(i)=3 then bsi_reversed_recoded(i)=2;
        else if bsi_to_recode_reverse(i)=2 then bsi_reversed_recoded(i)=3;
        else if bsi_to_recode_reverse(i)=1 then bsi_reversed_recoded(i)=4;
        else if bsi_reversed_recoded(i)=.;
    end;

    drop i;
run;

/* Step 3: Create the Calculated Score Columns */
data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Calculate the sum of specified columns */
    Attentional_Impulsiveness=sum(of BSI11_1_6_SCORE, BSI11_1_5_SCORE,
        BSI11_1_9_REVERSED, BSI11_1_11_SCORE, BSI11_1_20_REVERSED,
        BSI11_1_24_SCORE, BSI11_1_26_SCORE, BSI11_1_28_SCORE);
    Motor_Impulsiveness=sum(of BSI11_1_2_SCORE, BSI11_1_3_SCORE,
        BSI11_1_4_SCORE, BSI11_1_16_SCORE, BSI11_1_17_SCORE, BSI11_1_19_SCORE,
        BSI11_1_21_SCORE, BSI11_1_22_SCORE, BSI11_1_23_SCORE, BSI11_1_25_SCORE,
        BSI11_1_30_REVERSED);
    Nonplanning_Impulsiveness=sum(of BSI11_1_1_REVERSED, BSI11_1_7_REVERSED,
        BSI11_1_8_REVERSED, BSI11_1_10_REVERSED, BSI11_1_12_REVERSED,
        BSI11_1_13_REVERSED, BSI11_1_14_SCORE, BSI11_1_15_REVERSED,
        BSI11_1_18_SCORE, BSI11_1_27_SCORE, BSI11_1_29_REVERSED);
run;

/* II. WALI_NES (NEQ) Scoring */

/* Step 1: Print unique values in the WALI_NES Columns */
proc freq data=BARI.data_recoded;
    tables WALI_NES_1_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_2_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_3_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_4_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_5_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_6_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_7_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_8_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_9_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_10_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_11_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_12_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_13_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_14_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_16_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_17_1 / nocum nopercent;
run;

/* Step 2a: Recode WALI_NES */
data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_1_1 to WALI_NES_1_1_SCORE based on specified mappings */
    if WALI_NES_1_1='Not at all' then WALI_NES_1_1_SCORE=0;
    else if WALI_NES_1_1='A little' or WALI_NES_1_1='At little' then
        WALI_NES_1_1_SCORE=1;
    else if WALI_NES_1_1='Somewhat' then WALI_NES_1_1_SCORE=2;
    else if WALI_NES_1_1='Moderately' then WALI_NES_1_1_SCORE=3;
    else if WALI_NES_1_1='Very' then WALI_NES_1_1_SCORE=4;
    else WALI_NES_1_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_2_1 to WALI_NES_2_1_SCORE based on specified mappings */
    if WALI_NES_2_1='Before 9 am' then WALI_NES_2_1_SCORE=0;
    else if WALI_NES_2_1='9:01 am to 12pm' or WALI_NES_2_1='9:01 am - 12 pm'
        then WALI_NES_2_1_SCORE=1;
    else if WALI_NES_2_1='12:01 pm - 3 pm' or WALI_NES_2_1='12:01pm to 3pm' then
        WALI_NES_2_1_SCORE=2;
    else if WALI_NES_2_1='3:01 pm - 6 pm' or WALI_NES_2_1='3:01pm to 6pm' then
        WALI_NES_2_1_SCORE=3;
    else if WALI_NES_2_1='6:01 pm or later' then WALI_NES_2_1_SCORE=4;
    else WALI_NES_2_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_3_1 to WALI_NES_3_1_SCORE based on specified mappings */
    if WALI_NES_3_1='Not at all' then WALI_NES_3_1_SCORE=0;
    else if WALI_NES_3_1='A little' then WALI_NES_3_1_SCORE=1;
    else if WALI_NES_3_1='Somewhat' then WALI_NES_3_1_SCORE=2;
    else if WALI_NES_3_1='Very Much' then WALI_NES_3_1_SCORE=3;
    else if WALI_NES_3_1='Extremely' then WALI_NES_3_1_SCORE=4;
    else WALI_NES_3_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_4_1 to WALI_NES_4_1_SCORE based on specified mappings */
    if WALI_NES_4_1='Not at all' then WALI_NES_4_1_SCORE=0;
    else if WALI_NES_4_1='A little' then WALI_NES_4_1_SCORE=1;
    else if WALI_NES_4_1='Some' or WALI_NES_4_1='Somewhat' then
        WALI_NES_4_1_SCORE=2;
    else if WALI_NES_4_1='Very Much' then WALI_NES_4_1_SCORE=3;
    else if WALI_NES_4_1='Complete' or WALI_NES_4_1='Extremely' then
        WALI_NES_4_1_SCORE=4;
    else WALI_NES_4_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_5_1 to WALI_NES_5_1_SCORE based on specified mappings */
    if WALI_NES_5_1='None' then WALI_NES_5_1_SCORE=0;
    else if WALI_NES_5_1='1-25%' then WALI_NES_5_1_SCORE=1;
    else if WALI_NES_5_1='26-50%' then WALI_NES_5_1_SCORE=2;
    else if WALI_NES_5_1='51-75%' then WALI_NES_5_1_SCORE=3;
    else if WALI_NES_5_1='76-100%' then WALI_NES_5_1_SCORE=4;
    else WALI_NES_5_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_6_1 to WALI_NES_6_1_SCORE based on specified mappings */
    if WALI_NES_6_1='Not at all' then WALI_NES_6_1_SCORE=0;
    else if WALI_NES_6_1='A little' then WALI_NES_6_1_SCORE=1;
    else if WALI_NES_6_1='Somewhat' then WALI_NES_6_1_SCORE=2;
    else if WALI_NES_6_1='Very much' then WALI_NES_6_1_SCORE=3;
    else if WALI_NES_6_1='Extremely' then WALI_NES_6_1_SCORE=4;
    else WALI_NES_6_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_7_1 to WALI_NES_7_1_SCORE based on specified mappings */
    if WALI_NES_7_1 in ('Early Morning', 'Early morning',
        'My mood doesn''t change during the day') then WALI_NES_7_1_SCORE=0;
    else if WALI_NES_7_1='Late Morning' or WALI_NES_7_1='Late morning' then
        WALI_NES_7_1_SCORE=1;
    else if WALI_NES_7_1='Afternoon' then WALI_NES_7_1_SCORE=2;
    else if WALI_NES_7_1='Early Evening' or WALI_NES_7_1='Early evening' then
        WALI_NES_7_1_SCORE=3;
    else if WALI_NES_7_1='Night/Late Evening' or WALI_NES_7_1=
        'Night/Late evening' then WALI_NES_7_1_SCORE=4;
    else WALI_NES_7_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_8_1 to WALI_NES_8_1_SCORE based on specified mappings */
    if WALI_NES_8_1='Never' then WALI_NES_8_1_SCORE=0;
    else if WALI_NES_8_1='Sometimes' then WALI_NES_8_1_SCORE=1;
    else if WALI_NES_8_1='About half the time' then WALI_NES_8_1_SCORE=2;
    else if WALI_NES_8_1='Usually' then WALI_NES_8_1_SCORE=3;
    else if WALI_NES_8_1='Always' then WALI_NES_8_1_SCORE=4;
    else WALI_NES_8_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_9_1 to WALI_NES_9_1_SCORE based on specified mappings */
    if WALI_NES_9_1='Never' then WALI_NES_9_1_SCORE=0;
    else if WALI_NES_9_1='Less than once per week' then WALI_NES_9_1_SCORE=1;
    else if WALI_NES_9_1='About once per week' then WALI_NES_9_1_SCORE=2;
    else if WALI_NES_9_1='More than once per week' then WALI_NES_9_1_SCORE=3;
    else if WALI_NES_9_1='Every night' then WALI_NES_9_1_SCORE=4;
    else WALI_NES_9_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_10_1 to WALI_NES_10_1_SCORE based on specified mappings */
    if WALI_NES_10_1='Not at all' then WALI_NES_10_1_SCORE=0;
    else if WALI_NES_10_1='A little' then WALI_NES_10_1_SCORE=1;
    else if WALI_NES_10_1='Somewhat' then WALI_NES_10_1_SCORE=2;
    else if WALI_NES_10_1='Very much' then WALI_NES_10_1_SCORE=3;
    else if WALI_NES_10_1='Extremely' then WALI_NES_10_1_SCORE=4;
    else WALI_NES_10_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_11_1 to WALI_NES_11_1_SCORE based on specified mappings */
    if WALI_NES_11_1='Not at all' then WALI_NES_11_1_SCORE=0;
    else if WALI_NES_11_1='A little' then WALI_NES_11_1_SCORE=1;
    else if WALI_NES_11_1='Somewhat' then WALI_NES_11_1_SCORE=2;
    else if WALI_NES_11_1='Very much' then WALI_NES_11_1_SCORE=3;
    else if WALI_NES_11_1='Extremely' then WALI_NES_11_1_SCORE=4;
    else WALI_NES_11_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_12_1 to WALI_NES_12_1_SCORE based on specified mappings */
    if WALI_NES_12_1='Never' then WALI_NES_12_1_SCORE=0;
    else if WALI_NES_12_1='Sometimes' then WALI_NES_12_1_SCORE=1;
    else if WALI_NES_12_1='About half the time' then WALI_NES_12_1_SCORE=2;
    else if WALI_NES_12_1='Usually' then WALI_NES_12_1_SCORE=3;
    else if WALI_NES_12_1='Always' then WALI_NES_12_1_SCORE=4;
    else WALI_NES_12_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_13_1 to WALI_NES_13_1_SCORE based on specified mappings */
    if WALI_NES_13_1='Not at all' then WALI_NES_13_1_SCORE=0;
    else if WALI_NES_13_1='A little' then WALI_NES_13_1_SCORE=1;
    else if WALI_NES_13_1='Somewhat' then WALI_NES_13_1_SCORE=2;
    else if WALI_NES_13_1='Very much' then WALI_NES_13_1_SCORE=3;
    else if WALI_NES_13_1='Completely' then WALI_NES_13_1_SCORE=4;
    else WALI_NES_13_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_14_1 to WALI_NES_14_1_SCORE based on specified mappings */
    if WALI_NES_14_1='Not at all' then WALI_NES_14_1_SCORE=0;
    else if WALI_NES_14_1='A little' then WALI_NES_14_1_SCORE=1;
    else if WALI_NES_14_1='Some' then WALI_NES_14_1_SCORE=2;
    else if WALI_NES_14_1='Very much' then WALI_NES_14_1_SCORE=3;
    else if WALI_NES_14_1='Complete' then WALI_NES_14_1_SCORE=4;
    else WALI_NES_14_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_16_1 to WALI_NES_16_1_SCORE based on specified mappings */
    if WALI_NES_16_1='Not at all' then WALI_NES_16_1_SCORE=0;
    else if WALI_NES_16_1='A little' then WALI_NES_16_1_SCORE=1;
    else if WALI_NES_16_1='Some' then WALI_NES_16_1_SCORE=2;
    else if WALI_NES_16_1='Very much' then WALI_NES_16_1_SCORE=3;
    else if WALI_NES_16_1='Completely' then WALI_NES_16_1_SCORE=4;
    else WALI_NES_16_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_17_1 to WALI_NES_17_1_SCORE based on specified mappings */
    if WALI_NES_17_1='Not at all' then WALI_NES_17_1_SCORE=0;
    else if WALI_NES_17_1='A little' then WALI_NES_17_1_SCORE=1;
    else if WALI_NES_17_1='Some' then WALI_NES_17_1_SCORE=2;
    else if WALI_NES_17_1='Very much' then WALI_NES_17_1_SCORE=3;
    else if WALI_NES_17_1='Completely' then WALI_NES_17_1_SCORE=4;
    else WALI_NES_17_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

/* Step 2b: Reverse Coding for WALI_NES */
data BARI.data_recoded;
    set BARI.data_recoded;

    /* Reverse coding WALI_NES_1_1_SCORE to WALI_NES_1_1_REVERSED */
    if WALI_NES_1_1_SCORE=0 then WALI_NES_1_1_REVERSED=4;
    else if WALI_NES_1_1_SCORE=1 then WALI_NES_1_1_REVERSED=3;
    else if WALI_NES_1_1_SCORE=2 then WALI_NES_1_1_REVERSED=2;
    else if WALI_NES_1_1_SCORE=3 then WALI_NES_1_1_REVERSED=1;
    else if WALI_NES_1_1_SCORE=4 then WALI_NES_1_1_REVERSED=0;
    else WALI_NES_1_1_REVERSED=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    set BARI.data_recoded;

    /* Reverse coding WALI_NES_4_1_SCORE to WALI_NES_4_1_REVERSED */
    if WALI_NES_4_1_SCORE=0 then WALI_NES_4_1_REVERSED=4;
    else if WALI_NES_4_1_SCORE=1 then WALI_NES_4_1_REVERSED=3;
    else if WALI_NES_4_1_SCORE=2 then WALI_NES_4_1_REVERSED=2;
    else if WALI_NES_4_1_SCORE=3 then WALI_NES_4_1_REVERSED=1;
    else if WALI_NES_4_1_SCORE=4 then WALI_NES_4_1_REVERSED=0;
    else WALI_NES_4_1_REVERSED=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    set BARI.data_recoded;

    /* Reverse coding WALI_NES_14_1_SCORE to WALI_NES_14_1_REVERSED */
    if WALI_NES_14_1_SCORE=0 then WALI_NES_14_1_REVERSED=4;
    else if WALI_NES_14_1_SCORE=1 then WALI_NES_14_1_REVERSED=3;
    else if WALI_NES_14_1_SCORE=2 then WALI_NES_14_1_REVERSED=2;
    else if WALI_NES_14_1_SCORE=3 then WALI_NES_14_1_REVERSED=1;
    else if WALI_NES_14_1_SCORE=4 then WALI_NES_14_1_REVERSED=0;
    else WALI_NES_14_1_REVERSED=.;
    /* Assign missing value if none of the conditions are met */
run;

/* Step 5: Check the new columns match the frequency count of the old columns */
proc freq data=BARI.data_recoded;
    tables WALI_NES_1_1 WALI_NES_1_1_SCORE WALI_NES_1_1_REVERSED WALI_NES_2_1
        WALI_NES_2_1_SCORE WALI_NES_3_1 WALI_NES_3_1_SCORE WALI_NES_4_1
        WALI_NES_4_1_SCORE WALI_NES_4_1_REVERSED WALI_NES_5_1 WALI_NES_5_1_SCORE
        WALI_NES_6_1 WALI_NES_6_1_SCORE WALI_NES_7_1 WALI_NES_7_1_SCORE
        WALI_NES_8_1 WALI_NES_8_1_SCORE WALI_NES_9_1 WALI_NES_9_1_SCORE
        WALI_NES_10_1 WALI_NES_10_1_SCORE WALI_NES_11_1 WALI_NES_11_1_SCORE
        WALI_NES_12_1 WALI_NES_12_1_SCORE WALI_NES_13_1 WALI_NES_13_1_SCORE
        WALI_NES_14_1 WALI_NES_14_1_SCORE WALI_NES_14_1_REVERSED WALI_NES_16_1
        WALI_NES_16_1_SCORE WALI_NES_17_1 WALI_NES_17_1_SCORE / nocum nopercent;
run;
