%% Importing Data and using the Import Tool
% Instructions for how to import data into MATLAB
% Importing a csv file:
% 1. Navigate to the Import Tool by clicking the data.csv tab
% 2. In the Import Tool, click the green check mark labeled "Import Selection"
% 3. Verify that the table has been imported into your workspace by typing
% `data` in the live script. Then click "Submit"

% NOTES: If there is missing data when you are importing it, by default
% MATLAB will put 'NaN' in the cell for the missing value
% You can change that by clicking the "Edit Rule" icon

%% Creating Informative Scripts
% TUTORIAL: 
% Load data
load gCosts
% Convert prices
% Convert the prices from USD/gallon to USD/liter using the conversion
% factor saved in the variable gal2lit.
gal2lit = 0.2642;
Australia = gal2lit*Australia;
Germnay = gal2lit*Germany;
Mexico = gal2lit*Mexico;
Canada = gal2lit*Canada;

% Plot results
% Plot the converted prices for the years 1990 to 2008
plot(Year,Australia,"*--")
hold on
plot(Year,Germany,"*--")
plot(Year,Mexico,"*--")
plot(Year,Canada,"*--")
hold off
% Annotate the plot
title("International Gasoline Prices")
xlabel("Year")
ylabel("Price (USD/L)")
legend("Australia","Germany","Mexico","Canada",...
    "Location","northwest")

% The variables hourlyAus, hourlyGer,hourlyMex, and hourlyCan contain the
% average hourly income for the countries Australia, Germany, Mexico, and
% Canada respectively.
% You can convert the prices from USD per liter to hours per liter by
% dividing by these conversion factors using the / operator
Australia = Australia/hourlyAus
Germany = Germany/hourlyGer
Mexico = Mexico/hourlyMex
Canada = Canada/hourlyCan
% You can run each section by itself but everytime you do the numbers keep
% changing because you are scaling a vector that has already been scaled.
% For this reason, some people prefer to change the variable name when it
% is changed in a new section.
AustraliaH = Australia/hourlyAus
GermanyH = Germany/hourlyGer
MexicoH = Mexico/hourlyMex
CanadaH = Canada/hourlyCan

% When adding similar code, you can copy (Ctrl+C) and paste (Ctrl+V)
% commands and modify them as needed.
plot(Year,AustraliaH,"*--")
hold on
plot(Year,GermanyH,"*--")
plot(Year,MexicoH,"*--")
plot(Year,CanadaH,"*--")
hold off

% Annotate the plot
title("International Gasoline Prices")
xlabel("Year")
ylabel("Price (Hours Worked to Earn One Liter)")
legend("Australia","Germany","Mexico","Canada",...
    "Location","northwest")

%% Comments and Descriptive Text
% Comments in the code are text following a percentage sign (%)
% They can appear on lines by themselves or at the end of a line of code
% EX:
load gCosts
% Converts from US$/gal to US$/L
gal2lit = 0.2642; % conversion factor
Germany = gal2lit*Germany;
Australia = gal2lit*Australia;
Mexico = gal2lit*Mexico;

