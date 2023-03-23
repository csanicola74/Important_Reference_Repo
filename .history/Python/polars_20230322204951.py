
# https://pypi.org/project/polars/
# pip install polars

import pandas as pd
import polars as pl

df = pl.read_csv('cars.csv')
colors = df.select('color')

# the The select() function creates a new DataFrame that contains only the color column.
# We can now use the value_counts() function to count the number of occurrences of each color:

counts = colors.value_counts()

# The value_counts() function returns a new DataFrame that contains the count of each unique value in the original DataFrame.

# Finally, we can sort the counts DataFrame by the count column and display the top 5 most common colors:

top_colors = counts.sort('count', reverse=True).head(5)
print(top_colors)
The sort() function sorts the DataFrame by the count column in descending order, and the head() function returns the first 5 rows.

Polars and Pandas Syntax references:
Both libraries provide a wide range of data transformation functions that allow users to clean and manipulate their data. Here are some examples of data transformation code in Polars and Pandas.

Selecting Columns
To select columns from a DataFrame in Polars, we can use the select() function. Here's an example:


df = pl.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
selected_cols = df.select(['A'])
print(selected_cols)
In Pandas, we can use the indexing operator to select columns. Here’s an example:


df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
selected_cols = df['A']
print(selected_cols)
Filtering Rows
To filter rows in a DataFrame in Polars, we can use the filter() function. Here's an example:


df = pl.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
filtered_rows = df.filter(pl.col('A') > 1)
print(filtered_rows)
In Pandas, we can use boolean indexing to filter rows. Here’s an example:


df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
filtered_rows = df[df['A'] > 1]
print(filtered_rows)
GroupBy
To aggregate data in a DataFrame in Polars, we can use the groupby() function. Here's an example:


df = pl.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
grouped_data = df.groupby('A').agg(pl.sum('B'))
print(grouped_data)
In Pandas, we can use the groupby() function and the various aggregation functions provided by Pandas to aggregate data. Here's an example:


df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
grouped_data = df.groupby('A').agg({'B': 'sum'})
print(grouped_data)
Column Manipulations
Adding and Modifying Columns To add or modify columns in a DataFrame in Polars, we can use the with_column() function. Here's an example:


df = pl.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
new_df = df.with_column(pl.col('C') * 2)
print(new_df)
In Pandas, we can use the indexing operator to add or modify columns. Here’s an example:


df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
df['C'] = df['B'] * 2
print(df)
Join / Merge Operation
Merging DataFrames To merge two DataFrames in Polars, we can use the join() function. Here's an example:


df2 = pl.DataFrame({'A': [2, 3, 4], 'C': [7, 8, 9]})
merged_df = df1.join(df2, on='A', how='inner')
print(merged_df)
In Pandas, we can use the merge() function to merge two DataFrames. Here's an example:


df1 = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
df2 = pd.DataFrame({'A': [2, 3, 4], 'C': [7, 8, 9]})
merged_df = pd.merge(df1, df2, on='A', how='inner')
print(merged_df)
Pivoting Data
To pivot data in a DataFrame in Polars, we can use the pivot() function. Here's an example:


df = pl.DataFrame(
    {'A': [1, 1, 2, 2], 'B': [3, 4, 5, 6], 'C': ['X', 'Y', 'X', 'Y']})
pivoted_df = df.pivot(['A'], ['C'], 'B', agg=pl.sum)
print(pivoted_df)
In Pandas, we can use the pivot_table() function to pivot data. Here's an example:


df = pd.DataFrame(
    {'A': [1, 1, 2, 2], 'B': [3, 4, 5, 6], 'C': ['X', 'Y', 'X', 'Y']})
pivoted_df = pd.pivot_table(
    df, index='A', columns='C', values='B', aggfunc='sum')
print(pivoted_df)
Defining UDFs and Lazy Evaluation in Polars:
Polars supports lazy evaluation through the use of lazy expressions. These expressions are created using the Polars API and are not evaluated until they are explicitly requested. For example, in the following code snippet, we create a lazy expression using the filter method that filters rows in a DataFrame:


df = pl.DataFrame({
    'a': [1, 2, 3],
    'b': [4, 5, 6]
})
lazy_expr = df.lazy().filter(pl.col("a") > 1)
In this example, the filter method creates a lazy expression that filters rows where the value in the a column is greater than 1. This expression is not evaluated until it is explicitly requested.

To evaluate a lazy expression, we can use the collect method, which returns a new DataFrame with the result of the expression:

result = lazy_expr.collect()
print(result)
# Output:
shape: (2, 2)
╭─────┬─────╮
│ a   ┆ b   │
│ --- ┆ --- │
│ i64 ┆ i64 │
╞═════╪═════╡
│ 2   ┆ 5   │
│ 3   ┆ 6   │
╰─────┴─────╯
In this example, we use the collect method to evaluate the lazy expression and return a new DataFrame with the result of the expression. The result is a new DataFrame with the rows where the value in the a column is greater than 1.

Overall, lazy evaluation is an important concept in data frames and can help improve performance and reduce memory usage, especially when working with large datasets. Polars supports lazy evaluation through the use of lazy expressions, which can be created using the Polars API and evaluated using the collect method.

Custom functions can be defined using the udf(user-defined function) API. This allows users to create their own functions that can be used in DataFrame operations.

Here is an example of how to define a custom function using the Polars API:

    # Define a function that adds 10 to a value


def add_10(x: int) -> int:
    return x + 10


# Define a DataFrame
df = pl.DataFrame({
    'a': [1, 2, 3],
    'b': [4, 5, 6]
})

# Use the udf method to create a new column based on the add_10 function
df = df.with_column(pl.col("a").apply(lambda s: pl.lazy.udf(add_10)(s)))
print(df)
# Output

shape: (3, 3)
╭─────┬─────┬─────╮
│ a   ┆ b   ┆ a_0 │
│ --- ┆ --- ┆ --- │
│ i64 ┆ i64 ┆ i64 │
╞═════╪═════╪═════╡
│ 1   ┆ 4   ┆ 11  │
│ 2   ┆ 5   ┆ 12  │
│ 3   ┆ 6   ┆ 13  │
╰─────┴─────┴─────╯
In this example, we define a function add_10 that adds 10 to a value. We then create a DataFrame with two columns, a and b. Finally, we use the apply method to apply the add_10 function to the a column using the udf method. This creates a new column a_0 with the result of applying the add_10 function to each value in the a column.

Note that the udf method creates a lazy expression, which means that the function is not actually applied to the data until it is explicitly requested. This helps to improve performance and reduce memory usage.


credits — Tenor
In conclusion, here are the recommended use cases for choosing between Polars and Pandas:

If you need high-performance computing capabilities, Polars is the better choice. Polars is designed to take advantage of multiple CPU cores and supports multithreading, which allows for faster computation.
If you are working with complex data types, such as time-based data, Polars is the better choice. Polars supports a wider range of data types, including 64-bit integers and categorical data, which makes it more versatile for handling different types of data.
If you are looking for a user-friendly and easy-to-learn library, Pandas is the better choice. Pandas has a larger user community and a more extensive ecosystem of packages and tools that support it, which makes it more accessible for beginners.
If you need to define custom functions for data transformation, Polars is the better choice. Polars offers more flexibility in defining custom functions, as it supports the creation of vectorized functions that can operate on entire columns.
If you are working with datasets that contain a lot of null values, Polars is the better choice. Polars has more efficient null value handling than Pandas. For example, Polars stores null values in a separate bitset, which reduces the memory footprint of a DataFrame.
