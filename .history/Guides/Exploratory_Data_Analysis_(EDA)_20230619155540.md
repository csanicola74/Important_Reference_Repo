# Exploratory Data Analysis (EDA)

## Step 1: Importing Required Libraries

```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

```

## Step 2: Load Your Cleaned Dataset

_This dataset will come from after running the 'data_cleaning' script first_

> _Most datasets that you will be working with are going to be csv files. If you have an xls file instead, convert it to a csv file first._

- For importing from local files and especially when using 'example.py' files

`df = pd.read_csv('cleaned_healthcare_dataset.csv')`

- For importing from local files but using a Notebook environment, like Jupyter, with files ending in 'example.ipynb'

`df = pd.read_csv('C:/Users/Caroline/Documents/GitHub/reop_name/Data/Raw_Data/cleaned_healthcare_dataset.csv')`

## Step 3: Understanding Your Dataset

```python
# Look at the first 5 rows of the dataframe
print(df.head())

# Get summary information about your data
print(df.info())

# Get statistical summary of the data
print(df.describe())

```

## Step 4: Univariate Analysis

Univariate analysis is done with a single variable. Here, we're going to check the distribution of each variable.

```python
# Numerical Columns
df.hist(figsize=(10,10))
plt.tight_layout()
plt.show()

# For categorical columns use bar chart
for col in df.select_dtypes(include=['object']):
    plt.figure(figsize=(10,5))
    sns.countplot(df[col])
    plt.show()

```

## Step 5: Bivariate Analysis

Bivariate analysis is done with two variables to determine the relationship between them.

```python
# For numeric-numeric columns use scatterplot, pairplot or correlation matrix
sns.pairplot(df)
plt.show()

# For numeric-categorical columns use boxplot or violinplot
for col in df.select_dtypes(include=['object']):
    plt.figure(figsize=(10,5))
    sns.boxplot(x=col, y='numerical_column', data=df)  # Replace 'numerical_column' with your numerical column name
    plt.xticks(rotation=90)
    plt.show()

# For categorical-categorical columns use a cross-tabulation or stacked bar chart
pd.crosstab(df['categorical_column1'], df['categorical_column2'])  # Replace 'categorical_column1' and 'categorical_column2' with your column names

```

## Step 6: Correlation Matrix

A correlation matrix is a table showing correlation coefficients between many variables. Each cell in the table shows the correlation between two variables.

```python
corr = df.corr()
sns.heatmap(corr, annot=True)

```
