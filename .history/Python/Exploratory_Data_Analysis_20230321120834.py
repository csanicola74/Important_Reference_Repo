import geopandas as gpd  # Create geopandas dataframe from shape file
from shapely.geometry import Point
import shapefile as shp
import warnings
import numpy as np
import pandas as pd  # data processing, CSV file I/O (e.g. pd.read_csv)
import numpy as np  # linear algebra
import seaborn as sns
import matplotlib.pyplot as plt
%matplotlib inline
warnings.filterwarnings('ignore')
sns.set_style('whitegrid')


# The dataset (.csv file) is loaded using pandas as a data frame.

# Data loading as a dataframe
data = pd.read_csv('file.csv')

# to get the number of rows and columns in the dataset
data.shape  # (rows, columns)

# After that, I observed the descriptive statistics of the data frame, like the mean, median, minimum, maximum, standard deviation, and so on

data.describe()

# next is to check if there are any null values in the dataset
data.isnull().sum()

# The next step is to check the data types of the columns in the dataset
data.dtypes

##### DATA DETAILS #####
# see how many unique values are there in each column
data['COLUMN'].value_counts().head(20)

# to check the row number for a specific value in one of the columns
data.loc[data['COLUMN'] == 'SPECIFIC_VARIABLE']

# to check whether any rows are duplicated for a specific column
data[data['COLUMN'].duplicated()]

##### DATA VISUALIZATION #####
"""
The heatmap is created using the seaborn library to observe the correlation between the variables. 
The created correlation matrix shows the single correlation between each feature with other features on the dataset. 
The list of numbers provided gives an idea about the relation between the variables.

If 2 variables are correlated to each other by:

0.0 to 0.3, they are weakly correlated,

0.3 to 0.6, they are moderately correlated,

0.6 to 0.9, they are strongly correlated,

finally, >0.9, they are very strongly correlated

Positive and negative indicates whether the variables are directly or inversely related e.g. a correlation of -0.7 between 2 variables denote that if one variable increases, the other decreases strongly (as defined in the list above)
"""

f, ax = plt.subplots(figsize=(12, 10))
sns.heatmap(data.loc[:, ['COLUMN1', 'COLUMN2', 'COLUMN3', 'COLUMN4']].corr(),
            annot=True,
            linecolor='r',
            linewidths=.5,
            fmt='.1f',
            ax=ax)
plt.show()

# then use a pivot table to show particular values for a specific column
pd.pivot_table(data, values='Value', index=['COLUMN1', 'COLUMN2', 'COLUMN3'],
               aggfunc=max)


# Grouping by variables in a specific column
gkk = data.groupby('STATE/UT')
# Print the maximum value in each group
gkk.max()
