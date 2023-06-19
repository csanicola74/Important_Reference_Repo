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
