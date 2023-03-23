
# https://pypi.org/project/polars/
# pip install polars

import polars as pl

df = pl.read_csv('cars.csv')
colors = df.select('color')

# the The select() function creates a new DataFrame that contains only the color column.
# We can now use the value_counts() function to count the number of occurrences of each color:

counts = colors.value_counts()
