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
