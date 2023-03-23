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
