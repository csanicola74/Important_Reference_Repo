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
    tables WALI_NES_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_2 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_3_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_3_2 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_5 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_6 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_7 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_8 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_9 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_10_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_10_2 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_12 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_13 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_14 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_16_1 / nocum nopercent;
run;

proc freq data=BARI.data_recoded;
    tables WALI_NES_16_2 / nocum nopercent;
run;

/* Step 2a: Recode WALI_NES */
data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_1 to WALI_NES_1_SCORE based on specified mappings */
    if WALI_NES_1='Not at all' then WALI_NES_1_SCORE=0;
    else if WALI_NES_1='A little' or WALI_NES_1='At little' then
        WALI_NES_1_SCORE=1;
    else if WALI_NES_1='Somewhat' then WALI_NES_1_SCORE=2;
    else if WALI_NES_1='Moderately' then WALI_NES_1_SCORE=3;
    else if WALI_NES_1='Very' then WALI_NES_1_SCORE=4;
    else WALI_NES_1_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_2 to WALI_NES_2_SCORE based on specified mappings */
    if WALI_NES_2='Before 9 am' then WALI_NES_2_SCORE=0;
    else if WALI_NES_2='9:01 am to 12pm' or WALI_NES_2='9:01 am - 12 pm' then
        WALI_NES_2_SCORE=1;
    else if WALI_NES_2='12:01 pm - 3 pm' or WALI_NES_2='12:01pm to 3pm' then
        WALI_NES_2_SCORE=2;
    else if WALI_NES_2='3:01 pm - 6 pm' or WALI_NES_2='3:01pm to 6pm' then
        WALI_NES_2_SCORE=3;
    else if WALI_NES_2='6:01 pm or later' then WALI_NES_2_SCORE=4;
    else WALI_NES_2_SCORE=.;
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
    /* Recoding WALI_NES_3_2 to WALI_NES_3_2_SCORE based on specified mappings */
    if WALI_NES_3_2='Not at all' then WALI_NES_3_2_SCORE=0;
    else if WALI_NES_3_2='A little' then WALI_NES_3_2_SCORE=1;
    else if WALI_NES_3_2='Some' or WALI_NES_3_2='Somewhat' then
        WALI_NES_3_2_SCORE=2;
    else if WALI_NES_3_2='Very Much' then WALI_NES_3_2_SCORE=3;
    else if WALI_NES_3_2='Complete' or WALI_NES_3_2='Extremely' then
        WALI_NES_3_2_SCORE=4;
    else WALI_NES_3_2_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_5 to WALI_NES_5_SCORE based on specified mappings */
    if WALI_NES_5='None' then WALI_NES_5_SCORE=0;
    else if WALI_NES_5='1-25%' then WALI_NES_5_SCORE=1;
    else if WALI_NES_5='26-50%' then WALI_NES_5_SCORE=2;
    else if WALI_NES_5='51-75%' then WALI_NES_5_SCORE=3;
    else if WALI_NES_5='76-100%' then WALI_NES_5_SCORE=4;
    else WALI_NES_5_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_6 to WALI_NES_6_SCORE based on specified mappings */
    if WALI_NES_6='Not at all' then WALI_NES_6_SCORE=0;
    else if WALI_NES_6='A little' then WALI_NES_6_SCORE=1;
    else if WALI_NES_6='Somewhat' then WALI_NES_6_SCORE=2;
    else if WALI_NES_6='Very much' then WALI_NES_6_SCORE=3;
    else if WALI_NES_6='Extremely' then WALI_NES_6_SCORE=4;
    else WALI_NES_6_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_7 to WALI_NES_7_SCORE based on specified mappings */
    if WALI_NES_7 in ('Early Morning', 'Early morning',
        'My mood doesn''t change during the day') then WALI_NES_7_SCORE=0;
    else if WALI_NES_7='Late Morning' or WALI_NES_7='Late morning' then
        WALI_NES_7_SCORE=1;
    else if WALI_NES_7='Afternoon' then WALI_NES_7_SCORE=2;
    else if WALI_NES_7='Early Evening' or WALI_NES_7='Early evening' then
        WALI_NES_7_SCORE=3;
    else if WALI_NES_7='Night/Late Evening' or WALI_NES_7='Night/Late evening'
        then WALI_NES_7_SCORE=4;
    else WALI_NES_7_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_8 to WALI_NES_8_SCORE based on specified mappings */
    if WALI_NES_8='Never' then WALI_NES_8_SCORE=0;
    else if WALI_NES_8='Sometimes' then WALI_NES_8_SCORE=1;
    else if WALI_NES_8='About half the time' then WALI_NES_8_SCORE=2;
    else if WALI_NES_8='Usually' then WALI_NES_8_SCORE=3;
    else if WALI_NES_8='Always' then WALI_NES_8_SCORE=4;
    else WALI_NES_8_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_9 to WALI_NES_9_SCORE based on specified mappings */
    if WALI_NES_9='Never' then WALI_NES_9_SCORE=0;
    else if WALI_NES_9='Less than once per week' then WALI_NES_9_SCORE=1;
    else if WALI_NES_9='About once per week' then WALI_NES_9_SCORE=2;
    else if WALI_NES_9='More than once per week' then WALI_NES_9_SCORE=3;
    else if WALI_NES_9='Every night' then WALI_NES_9_SCORE=4;
    else WALI_NES_9_SCORE=.;
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
    /* Recoding WALI_NES_10_2 to WALI_NES_10_2_SCORE based on specified mappings */
    if WALI_NES_10_2='Not at all' then WALI_NES_10_2_SCORE=0;
    else if WALI_NES_10_2='A little' then WALI_NES_10_2_SCORE=1;
    else if WALI_NES_10_2='Somewhat' then WALI_NES_10_2_SCORE=2;
    else if WALI_NES_10_2='Very much' then WALI_NES_10_2_SCORE=3;
    else if WALI_NES_10_2='Extremely' then WALI_NES_10_2_SCORE=4;
    else WALI_NES_10_2_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_12 to WALI_NES_12_SCORE based on specified mappings */
    if WALI_NES_12='Never' then WALI_NES_12_SCORE=0;
    else if WALI_NES_12='Sometimes' then WALI_NES_12_SCORE=1;
    else if WALI_NES_12='About half the time' then WALI_NES_12_SCORE=2;
    else if WALI_NES_12='Usually' then WALI_NES_12_SCORE=3;
    else if WALI_NES_12='Always' then WALI_NES_12_SCORE=4;
    else WALI_NES_12_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_13 to WALI_NES_13_SCORE based on specified mappings */
    if WALI_NES_13='Not at all' then WALI_NES_13_SCORE=0;
    else if WALI_NES_13='A little' then WALI_NES_13_SCORE=1;
    else if WALI_NES_13='Somewhat' then WALI_NES_13_SCORE=2;
    else if WALI_NES_13='Very much' then WALI_NES_13_SCORE=3;
    else if WALI_NES_13='Completely' then WALI_NES_13_SCORE=4;
    else WALI_NES_13_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding WALI_NES_14 to WALI_NES_14_SCORE based on specified mappings */
    if WALI_NES_14='Not at all' then WALI_NES_14_SCORE=0;
    else if WALI_NES_14='A little' then WALI_NES_14_SCORE=1;
    else if WALI_NES_14='Some' then WALI_NES_14_SCORE=2;
    else if WALI_NES_14='Very much' then WALI_NES_14_SCORE=3;
    else if WALI_NES_14='Complete' then WALI_NES_14_SCORE=4;
    else WALI_NES_14_SCORE=.;
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
    /* Recoding WALI_NES_16_2 to WALI_NES_16_2_SCORE based on specified mappings */
    if WALI_NES_16_2='Not at all' then WALI_NES_16_2_SCORE=0;
    else if WALI_NES_16_2='A little' then WALI_NES_16_2_SCORE=1;
    else if WALI_NES_16_2='Some' then WALI_NES_16_2_SCORE=2;
    else if WALI_NES_16_2='Very much' then WALI_NES_16_2_SCORE=3;
    else if WALI_NES_16_2='Completely' then WALI_NES_16_2_SCORE=4;
    else WALI_NES_16_2_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

/* Step 2b: Reverse Coding for WALI_NES */
data BARI.data_recoded;
    set BARI.data_recoded;

    /* Reverse coding WALI_NES_1_SCORE to WALI_NES_1_REVERSED */
    if WALI_NES_1_SCORE=0 then WALI_NES_1_REVERSED=4;
    else if WALI_NES_1_SCORE=1 then WALI_NES_1_REVERSED=3;
    else if WALI_NES_1_SCORE=2 then WALI_NES_1_REVERSED=2;
    else if WALI_NES_1_SCORE=3 then WALI_NES_1_REVERSED=1;
    else if WALI_NES_1_SCORE=4 then WALI_NES_1_REVERSED=0;
    else WALI_NES_1_REVERSED=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    set BARI.data_recoded;

    /* Reverse coding WALI_NES_3_2_SCORE to WALI_NES_3_2_REVERSED */
    if WALI_NES_3_2_SCORE=0 then WALI_NES_3_2_REVERSED=4;
    else if WALI_NES_3_2_SCORE=1 then WALI_NES_3_2_REVERSED=3;
    else if WALI_NES_3_2_SCORE=2 then WALI_NES_3_2_REVERSED=2;
    else if WALI_NES_3_2_SCORE=3 then WALI_NES_3_2_REVERSED=1;
    else if WALI_NES_3_2_SCORE=4 then WALI_NES_3_2_REVERSED=0;
    else WALI_NES_3_2_REVERSED=.;
    /* Assign missing value if none of the conditions are met */
run;

data BARI.data_recoded;
    set BARI.data_recoded;

    /* Reverse coding WALI_NES_14_SCORE to WALI_NES_14_REVERSED */
    if WALI_NES_14_SCORE=0 then WALI_NES_14_REVERSED=4;
    else if WALI_NES_14_SCORE=1 then WALI_NES_14_REVERSED=3;
    else if WALI_NES_14_SCORE=2 then WALI_NES_14_REVERSED=2;
    else if WALI_NES_14_SCORE=3 then WALI_NES_14_REVERSED=1;
    else if WALI_NES_14_SCORE=4 then WALI_NES_14_REVERSED=0;
    else WALI_NES_14_REVERSED=.;
    /* Assign missing value if none of the conditions are met */
run;

/* Step 5: Check the new columns match the frequency count of the old columns */
proc freq data=BARI.data_recoded;
    tables WALI_NES_1 WALI_NES_1_SCORE WALI_NES_1_REVERSED WALI_NES_2
        WALI_NES_2_SCORE WALI_NES_3_1 WALI_NES_3_1_SCORE WALI_NES_3_2
        WALI_NES_3_2_SCORE WALI_NES_3_2_REVERSED WALI_NES_5 WALI_NES_5_SCORE
        WALI_NES_6 WALI_NES_6_SCORE WALI_NES_7 WALI_NES_7_SCORE WALI_NES_8
        WALI_NES_8_SCORE WALI_NES_9 WALI_NES_9_SCORE WALI_NES_10_1
        WALI_NES_10_1_SCORE WALI_NES_10_2 WALI_NES_10_2_SCORE WALI_NES_12
        WALI_NES_12_SCORE WALI_NES_13 WALI_NES_13_SCORE WALI_NES_14
        WALI_NES_14_SCORE WALI_NES_14_REVERSED WALI_NES_16_1 WALI_NES_16_1_SCORE
        WALI_NES_16_2 WALI_NES_16_2_SCORE / nocum nopercent;
run;

/* III. Brief Cope Scoring */

/* Step 1: Recode all columns to numeric score */
data BARI.data_recoded;
    set BARI.data_recoded;

    /* Define an array for the columns we are recodding */
    array brief_to_recode(*) Q367_1 Q367_2 Q367_3 Q367_4 Q367_5 Q367_6 Q367_7
        Q367_8 Q367_9 Q367_10 Q367_11 Q367_12 Q367_13 Q367_14 Q367_15 Q367_16
        Q367_17 Q367_18 Q367_19 Q367_20 Q367_21 Q367_22 Q367_23 Q367_24 Q367_25
        Q367_26 Q367_27 Q367_28;
    /* Columns to be recoded */
    array brief_recoded(*) Q367_1_SCORE Q367_2_SCORE Q367_3_SCORE Q367_4_SCORE
        Q367_5_SCORE Q367_6_SCORE Q367_7_SCORE Q367_8_SCORE Q367_9_SCORE
        Q367_10_SCORE Q367_11_SCORE Q367_12_SCORE Q367_13_SCORE Q367_14_SCORE
        Q367_15_SCORE Q367_16_SCORE Q367_17_SCORE Q367_18_SCORE Q367_19_SCORE
        Q367_20_SCORE Q367_21_SCORE Q367_22_SCORE Q367_23_SCORE Q367_24_SCORE
        Q367_25_SCORE Q367_26_SCORE Q367_27_SCORE Q367_28_SCORE;
    /* New Columns made from recoding */
    /* Loop through each element in the array */
    do i=1 to dim(brief_to_recode);
        /* Apply specific recoding logic */
        if brief_to_recode(i)='I haven''t been doing it at all' then
            brief_recoded(i)=1;
        else if brief_to_recode(i)='I''ve been doing this a little bit' then
            brief_recoded(i)=2;
        else if brief_to_recode(i)='I''ve been doing this a medium amount' then
            brief_recoded(i)=3;
        else if brief_to_recode(i)='I''ve been doing this a lot' then
            brief_recoded(i)=4;
        else brief_recoded(i)=.; /* For missing or undefined categories */
    end;

    drop i;
    /* Optional: drop the loop index variable from the resulting dataset */
run;

/* Step 2: Add in the scored columns */
data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Calculate the sum of specified columns */
    Brief_Self_Distraction=sum(of Q367_1_SCORE, Q367_19_SCORE);
    Brief_Active_Coping=sum(of Q367_2_SCORE, Q367_7_SCORE);
    Brief_Denial=sum(of Q367_3_SCORE, Q367_8_SCORE);
    Brief_Substance_Use=sum(of Q367_4_SCORE, Q367_11_SCORE);
    Brief_Emotional_Support=sum(of Q367_5_SCORE, Q367_15_SCORE);
    Brief_Instrumental_Support=sum(of Q367_10_SCORE, Q367_23_SCORE);
    Brief_Behavioral_Disengagement=sum(of Q367_6_SCORE, Q367_16_SCORE);
    Brief_Venting=sum(of Q367_9_SCORE, Q367_21_SCORE);
    Brief_Positive_Reframing=sum(of Q367_12_SCORE, Q367_17_SCORE);
    Brief_Planning=sum(of Q367_14_SCORE, Q367_25_SCORE);
    Brief_Humor=sum(of Q367_18_SCORE, Q367_28_SCORE);
    Brief_Acceptance=sum(of Q367_20_SCORE, Q367_24_SCORE);
    Brief_Religion=sum(of Q367_22_SCORE, Q367_27_SCORE);
    Brief_Self_Blame=sum(of Q367_13_SCORE, Q367_26_SCORE);
run;

/* Step 3: Check the frequency scores of the new scored columns */
proc freq data=BARI.data_recoded;
    tables Brief_Self_Distraction Brief_Active_Coping Brief_Denial
        Brief_Substance_Use Brief_Emotional_Support Brief_Instrumental_Support
        Brief_Behavioral_Disengagement Brief_Venting Brief_Positive_Reframing
        Brief_Planning Brief_Humor Brief_Acceptance Brief_Religion
        Brief_Self_Blame / nocum nopercent;
run;

/* IV. Insomnia Severity Index (ISI) */
proc freq data=BARI.data_recoded;
    tables ISI_123_1 ISI_123_2 ISI_123_3 ISI_4_1 ISI_5_1 ISI_6_1 ISI_7_1 / nocum
        nopercent;
run;

/* Step 1: Recode all columns to numeric score */
data BARI.data_recoded;
    set BARI.data_recoded;

    /* Define an array for the columns we are recoding */
    array isi_to_recode(*) ISI_123_1 ISI_123_2 ISI_123_3 ISI_4_1 ISI_5_1 ISI_6_1
        ISI_7_1;
    /* Columns to be recoded */
    array isi_recoded(*) ISI_123_1_SCORE ISI_123_2_SCORE ISI_123_3_SCORE
        ISI_4_1_SCORE ISI_5_1_SCORE ISI_6_1_SCORE ISI_7_1_SCORE;
    /* New Columns made from recoding */
    /* Loop through each element in the array */
    do i=1 to dim(isi_to_recode);
        /* Use compress function to keep only digits */
        isi_recoded(i)=input(compress(isi_to_recode(i), , 'kd'), best.);
    end;

    drop i;
    /* Optional: drop the loop index variable from the resulting dataset */
run;

/* Step 3: Check to see if the the frequencies match */
proc freq data=BARI.data_recoded;
    tables ISI_123_1 ISI_123_1_SCORE ISI_123_2 ISI_123_2_SCORE ISI_123_3
        ISI_123_3_SCORE ISI_4_1 ISI_4_1_SCORE ISI_5_1 ISI_5_1_SCORE ISI_6_1
        ISI_6_1_SCORE ISI_7_1 ISI_7_1_SCORE / nocum nopercent;
run;

/* Step 4: Create a scored column for the cumulative results */
data BARI.data_recoded;
    set BARI.data_recoded;

    /* Define an array for the columns to sum up */
    array score_cols(*) ISI_123_1_SCORE ISI_123_2_SCORE ISI_123_3_SCORE
        ISI_4_1_SCORE ISI_5_1_SCORE ISI_6_1_SCORE ISI_7_1_SCORE;

    /* Calculate the total score */
    isi_total_score=sum(of score_cols(*));

    /* Categorize the total score */
    if isi_total_score <= 7 then insomnia_category=
        'No clinically significant insomnia';
    else if isi_total_score <= 14 then insomnia_category=
        'Subthreshold insomnia';
    else if isi_total_score <= 21 then insomnia_category=
        'Clinical insomnia (moderate severity)';
    else if isi_total_score <= 28 then insomnia_category=
        'Clinical insomnia (severe)';
    else insomnia_category='Unknown';
        /* In case total exceeds 28 or other edge cases */
run;

/* Step 5: Print the new columns to check */
proc freq data=BARI.data_recoded;
    tables isi_total_score insomnia_category;
run;

/* V. Yale Food Addiction Scale (YFAS) */

/* Step 1: Verify values in the columns */
proc freq data=BARI.data_recoded;
    tables YFAS_1_1 YFAS_1_2 YFAS_1_3 YFAS_1_4 YFAS_1_5 YFAS_1_6 YFAS_1_7
        YFAS_1_8 YFAS_1_9 YFAS_1_10 YFAS_1_11 YFAS_1_12 YFAS_1_13 YFAS_1_14
        YFAS_1_15 YFAS_1_16 YFAS_2_1 YFAS_2_2 YFAS_2_3 YFAS_2_4 YFAS_2_5
        YFAS_2_6 YFAS_2_7 YFAS_2_8 YFAS_3 / nocum nopercent;
run;

/* Step 2: Recode columns based on official scoring criteria */

/* The following questions are scored 0 = (0), 1 = (1): #19, #20, #21, #22  */
data BARI.data_recoded;
    set BARI.data_recoded;

    /* Define an array for the columns we are recodding */
    array yfas_to_recode(*) YFAS_2_3 YFAS_2_4 YFAS_2_5 YFAS_2_6;
    /* Columns to be recoded */
    array yfas_recoded(*) YFAS_2_3_SCORE YFAS_2_4_SCORE YFAS_2_5_SCORE
        YFAS_2_6_SCORE;
    /* New Columns made from recoding */
    /* Loop through each element in the array */
    do i=1 to dim(yfas_to_recode);
        /* Apply specific recoding logic */
        if yfas_to_recode(i)='YES' then yfas_recoded(i)=1;
        else if yfas_to_recode(i)='NO' then yfas_recoded(i)=0;
        else yfas_recoded(i)=.; /* For missing or undefined categories */
    end;

    drop i;
    /* Optional: drop the loop index variable from the resulting dataset */
run;

proc freq data=BARI.data_recoded;
    tables YFAS_2_3_SCORE YFAS_2_4_SCORE YFAS_2_5_SCORE YFAS_2_6_SCORE / nocum
        nopercent;
run;

/* The following question is scored 0 = (1), 1 = (0): #24 */
data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Recoding YFAS_2_8 to YFAS_2_8_SCORE based on specified mappings */
    if YFAS_2_8='YES' then YFAS_2_8_SCORE=0;
    else if YFAS_2_8='NO' then YFAS_2_8_SCORE=1;
    else YFAS_2_8_SCORE=.;
    /* Assign missing value if none of the conditions are met */
run;

proc freq data=BARI.data_recoded;
    tables YFAS_2_8 YFAS_2_8_SCORE / nocum nopercent;
run;

/* The following questions are scored 0 = (0 thru 1), 1 = (2 thru 4): #8, #10, #11 */
data BARI.data_recoded;
    set BARI.data_recoded;

    /* Define an array for the columns we are recodding */
    array yfas_to_recode(*) YFAS_1_8 YFAS_1_10 YFAS_1_11;
    /* Columns to be recoded */
    array yfas_recoded(*) YFAS_1_8_SCORE YFAS_1_10_SCORE YFAS_1_11_SCORE;
    /* New Columns made from recoding */
    /* Loop through each element in the array */
    do i=1 to dim(yfas_to_recode);
        /* Apply specific recoding logic */
        if yfas_to_recode(i)='Never' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='Once a month' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='2-4 times a month' then yfas_recoded(i)=1;
        else if yfas_to_recode(i)='2-3 times a week' then yfas_recoded(i)=1;
        else if yfas_to_recode(i)='4 or more times or daily' then
            yfas_recoded(i)=1;
        else yfas_recoded(i)=.; /* For missing or undefined categories */
    end;

    drop i;
    /* Optional: drop the loop index variable from the resulting dataset */
run;

proc freq data=BARI.data_recoded;
    tables YFAS_1_8_SCORE YFAS_1_10_SCORE YFAS_1_11_SCORE / nocum nopercent;
run;

/* The following questions are scored 0 = (0 thru 2), 1 = (3 & 4): #3, #5, #7, #9, #12, #13, #14, #15, #16 */
data BARI.data_recoded;
    set BARI.data_recoded;

    /* Define an array for the columns we are recodding */
    array yfas_to_recode(*) YFAS_1_3 YFAS_1_5 YFAS_1_7 YFAS_1_9 YFAS_1_12
        YFAS_1_13 YFAS_1_14 YFAS_1_15 YFAS_1_16;
    /* Columns to be recoded */
    array yfas_recoded(*) YFAS_1_3_SCORE YFAS_1_5_SCORE YFAS_1_7_SCORE
        YFAS_1_9_SCORE YFAS_1_12_SCORE YFAS_1_13_SCORE YFAS_1_14_SCORE
        YFAS_1_15_SCORE YFAS_1_16_SCORE;
    /* New Columns made from recoding */
    /* Loop through each element in the array */
    do i=1 to dim(yfas_to_recode);
        /* Apply specific recoding logic */
        if yfas_to_recode(i)='Never' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='Once a month' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='2-4 times a month' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='2-3 times a week' then yfas_recoded(i)=1;
        else if yfas_to_recode(i)='4 or more times or daily' then
            yfas_recoded(i)=1;
        else yfas_recoded(i)=.; /* For missing or undefined categories */
    end;

    drop i;
    /* Optional: drop the loop index variable from the resulting dataset */
run;

proc freq data=BARI.data_recoded;
    tables YFAS_1_3_SCORE YFAS_1_5_SCORE YFAS_1_7_SCORE YFAS_1_9_SCORE
        YFAS_1_12_SCORE YFAS_1_13_SCORE YFAS_1_14_SCORE YFAS_1_15_SCORE
        YFAS_1_16_SCORE / nocum nopercent;
run;

/* The following questions are scored 0 = (0 thru 3), 1 = (4): #1, #2, #4, #6 */
data BARI.data_recoded;
    set BARI.data_recoded;

    /* Define an array for the columns we are recodding */
    array yfas_to_recode(*) YFAS_1_1 YFAS_1_2 YFAS_1_4 YFAS_1_6;
    /* Columns to be recoded */
    array yfas_recoded(*) YFAS_1_1_SCORE YFAS_1_2_SCORE YFAS_1_4_SCORE
        YFAS_1_6_SCORE;
    /* New Columns made from recoding */
    /* Loop through each element in the array */
    do i=1 to dim(yfas_to_recode);
        /* Apply specific recoding logic */
        if yfas_to_recode(i)='Never' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='Once a month' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='2-4 times a month' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='2-3 times a week' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='4 or more times or daily' then
            yfas_recoded(i)=1;
        else yfas_recoded(i)=.; /* For missing or undefined categories */
    end;

    drop i;
    /* Optional: drop the loop index variable from the resulting dataset */
run;

proc freq data=BARI.data_recoded;
    tables YFAS_1_1_SCORE YFAS_1_2_SCORE YFAS_1_4_SCORE YFAS_1_6_SCORE / nocum
        nopercent;
run;

/* The following questions are scored 0 = (0 thru 4), 1 = (5): #25 */
data BARI.data_recoded;
    set BARI.data_recoded;

    /* Define an array for the columns we are recodding */
    array yfas_to_recode(*) YFAS_3;
    /* Columns to be recoded */
    array yfas_recoded(*) YFAS_3_SCORE;
    /* New Columns made from recoding */
    /* Loop through each element in the array */
    do i=1 to dim(yfas_to_recode);
        /* Apply specific recoding logic */
        if yfas_to_recode(i)='1 time' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='2 times' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='3 times' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='4 times' then yfas_recoded(i)=0;
        else if yfas_to_recode(i)='5 or more times' then yfas_recoded(i)=1;
        else yfas_recoded(i)=.; /* For missing or undefined categories */
    end;

    drop i;
    /* Optional: drop the loop index variable from the resulting dataset */
run;

proc freq data=BARI.data_recoded;
    tables YFAS_3 YFAS_3_SCORE / nocum nopercent;
run;

/* Step 3: Create new scored columns based on official criteria */
/* 1) Substance taken in larger amount and for longer period than intended */
/* Questions #1, #2, #3 */
/* 2) Persistent desire or repeated unsuccessful attempts to quit */
/* Questions #4, #22, # 24, #25 */
/* 3) Much time/activity to obtain, use, recover */
/* Questions #5, #6, #7 */
/* 4) Important social, occupational, or recreational activities given up or reduced */
/* Questions #8, #9, #10, #11 */
/* 5) Use continues despite knowledge of adverse consequences (e.g., failure to fulfill role obligation, use  */
/* when physically hazardous) */
/* Question #19 */
/* 6) Tolerance (marked increase in amount; marked decrease in effect) */
/* Questions #20, #21 */
/* 7) Characteristic withdrawal symptoms; substance taken to relieve withdrawal */
/* Questions #12, #13, #14 */
/* 8) Use causes clinically significant impairment or distress */

/* Questions #15, #16 */
data BARI.data_recoded;
    /* Specify the dataset where the new column will be added */
    set BARI.data_recoded; /* Read the existing dataset */
    /* Calculate the sum of specified columns */
    yfas_scale_1=sum(of YFAS_1_1_SCORE, YFAS_1_2_SCORE, YFAS_1_3_SCORE);
    yfas_scale_2=sum(of YFAS_1_4_SCORE, YFAS_2_6_SCORE, YFAS_2_8_SCORE,
        YFAS_3_SCORE);
    yfas_scale_3=sum(of YFAS_1_5_SCORE, YFAS_1_6_SCORE, YFAS_1_7_SCORE);
    yfas_scale_4=sum(of YFAS_1_8_SCORE, YFAS_1_9_SCORE, YFAS_1_10_SCORE,
        YFAS_1_11_SCORE);
    yfas_scale_5=sum(of YFAS_2_3_SCORE);
    yfas_scale_6=sum(of YFAS_2_4_SCORE, YFAS_2_5_SCORE);
    yfas_scale_7=sum(of YFAS_1_12_SCORE, YFAS_1_13_SCORE, YFAS_1_14_SCORE);
    yfas_scale_8=sum(of YFAS_1_15_SCORE, YFAS_1_16_SCORE);
run;

proc freq data=BARI.data_recoded;
    tables yfas_scale_1 yfas_scale_2 yfas_scale_3 yfas_scale_4 yfas_scale_5
        yfas_scale_6 yfas_scale_7 yfas_scale_8 / nocum nopercent;
run;

data BARI.data_recoded;
    set BARI.data_recoded;

    /* Define an array for the columns we are recoding */
    array yfas_to_recode(*) yfas_scale_1 yfas_scale_2 yfas_scale_3 yfas_scale_4
        yfas_scale_5 yfas_scale_6 yfas_scale_7 yfas_scale_8;

    /* Columns to be recoded */
    array yfas_recoded(*) $20 yfas_scale_1_criterion_met
        yfas_scale_2_criterion_met yfas_scale_3_criterion_met
        yfas_scale_4_criterion_met yfas_scale_5_criterion_met
        yfas_scale_6_criterion_met yfas_scale_7_criterion_met
        yfas_scale_8_criterion_met;

    /* Loop through each element in the array */
    do i=1 to dim(yfas_to_recode);
        /* Apply specific recoding logic */
        if yfas_to_recode(i) > 0 then yfas_recoded(i)='Criterion Met';
        else if yfas_to_recode(i)=0 then yfas_recoded(i)='Criterion Not Met';
        else yfas_recoded(i)=''; /* For missing or undefined categories */
    end;

    drop i;
        /* Optional: drop the loop index variable from the resulting dataset */
run;

proc freq data=BARI.data_recoded;
    tables yfas_scale_1_criterion_met yfas_scale_2_criterion_met
        yfas_scale_3_criterion_met yfas_scale_4_criterion_met
        yfas_scale_5_criterion_met yfas_scale_6_criterion_met
        yfas_scale_7_criterion_met yfas_scale_8_criterion_met / nocum nopercent;
run;
