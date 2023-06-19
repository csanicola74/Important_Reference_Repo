# Feature Engineering

## Step 1: Importing Required Libraries

```python
import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
```

## Step 2: Load Your Cleaned Dataset

_This dataset will come from after running the 'data_cleaning' script first_

> _Most datasets that you will be working with are going to be csv files. If you have an xls file instead, convert it to a csv file first._

- For importing from local files and especially when using 'example.py' files

`df = pd.read_csv('cleaned_healthcare_dataset.csv')`

- For importing from local files but using a Notebook environment, like Jupyter, with files ending in 'example.ipynb'

`df = pd.read_csv('C:/Users/Caroline/Documents/GitHub/reop_name/Data/Raw_Data/cleaned_healthcare_dataset.csv')`

## Step 3: Numerical Feature Engineering

For #numerical_features, you might create derived features, binning, normalization, etc. Here we'll demonstrate normalization using `StandardScaler`.

```python
# List of numerical columns
num_cols = df.select_dtypes(include=['int64', 'float64']).columns

# Apply Standard Scaler for numerical columns
scaler = StandardScaler()
df[num_cols] = scaler.fit_transform(df[num_cols])
```

## Step 4: Categorical Feature Engineering

For categorical features, one common operation is One-Hot Encoding. This creates binary columns from the category feature where 1 indicates the presence of the feature and 0 indicates the absence.

```python
# List of categorical columns
cat_cols = df.select_dtypes(include=['object']).columns

# Apply One Hot Encoder for categorical columns
encoder = OneHotEncoder(drop='first')
dummies = pd.DataFrame(encoder.fit_transform(df[cat_cols]).toarray(),
                       columns=encoder.get_feature_names_out(cat_cols))
df = pd.concat([df, dummies], axis=1)
df = df.drop(columns=cat_cols)
```

## Step 5: Dealing with Date and Time Features (If any)

If there are date and time features, you can derive a lot of information such as year, month, day, weekday/weekend, etc. This depends on the dataset and the problem statement.

```python
# Assume 'date_column' is the date column in your dataframe
df['date_column'] = pd.to_datetime(df['date_column'])

# Create features based on date column
df['Year'] = df['date_column'].dt.year
df['Month'] = df['date_column'].dt.month
df['Day'] = df['date_column'].dt.day
df['DayOfWeek'] = df['date_column'].dt.dayofweek  # Monday=0, Sunday=6

```
