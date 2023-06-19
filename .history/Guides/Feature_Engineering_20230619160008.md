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
