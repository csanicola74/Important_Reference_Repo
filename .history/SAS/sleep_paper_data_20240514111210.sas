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
