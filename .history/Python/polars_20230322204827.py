
# https://pypi.org/project/polars/
# pip install polars

import polars as pl

df = pl.read_csv("data.csv")
df.head()

