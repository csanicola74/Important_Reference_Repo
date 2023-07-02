# I. Concepts

## 1. Data Structures:

In Python, #data_structures are #containers that organize and group data types together in different ways. Here are a few basic types of data structures:

- **Lists**: A #list is a collection of items that are ordered and #mutable (changeable). They allow duplicate members. Think of a shopping list where you can add, remove or chage items.
- **Tuples**: A #tuple is similar to a list, but it's #immutable (unchangeable). Think of a tuple as a GPS coordinate. The latitude and longitude that define a location on the Earth can't be changed.
- **Sets**: A #set is a collection which is unordered and unindexed. Sets don't allow duplicates. Imagine a real-world set like a bag of unique marbles.
- **Dictionaries**: A #dictionary is a collection of key-value pairs that are unordered, changeable, and indexed. It's like an English dictionary, where for every word (the key), there's a definition (the value).

## 2. Control Flow:

#Control_flow is the order in which the program's code executes. Here are some basic control flow concepts:

- **If statements**: #If_statements are used for decision-making operations. They run a specific block of code if a condition is true. If I'm hungry (condition is true), then I'll eat (run a specific block of code).

  - _Function_: #calculate*average_age*
  - _Purpose_: To calculate the average age of patients in a dataset who have a specific condition
  - _Existed functions_: pandas.DataFrame.loc, pandas.DataFrame.mean
  - ```python
    def calculate_average_age(df, condition_column, condition_value):
        try:
            if condition_column not in df.columns:
                raise ValueError(f"{condition_column} does not exist in dataframe")
            if condition_value not in df[condition_column].unique():
                raise ValueError(f"{condition_value} does not exist in {condition_column}")

            patients_with_condition = df.loc[df[condition_column] == condition_value]
            average_age = patients_with_condition['age'].mean()

            return average_age

        except Exception as e:
            print(f"An error occurred: {str(e)}")
            return None
    ```

  - _Unit Test:_
  - ```python
    def test_calculate_average_age():
        data = {
            'patient_id': [1, 2, 3, 4, 5],
            'age': [25, 30, 35, 40, 45],
            'condition': ['healthy', 'sick', 'healthy', 'sick', 'healthy']
        }

        df = pd.DataFrame(data)

        average_age = calculate_average_age(df, 'condition', 'sick')

        assert average_age == 35

    test_calculate_average_age()
    ```

- **For loops**: #For_loops are used for iterating over a sequence (like #list, #tuple, #dictionary, #set, or #string). It's like when you're going through every item on your shopping list one by one.

  - _Function_: count_condition_by_age
  - _Purpose_: To count the number of occurrences of a specific condition for each unique age in the dataset
  - _Existed functions_: pandas.DataFrame.loc, pandas.DataFrame.unique
  - ```python
    def count_condition_by_age(df, condition_column, condition_value):
        try:
            if condition_column not in df.columns:
                raise ValueError(f"{condition_column} does not exist in dataframe")
            if condition_value not in df[condition_column].unique():
                raise ValueError(f"{condition_value} does not exist in {condition_column}")

            condition_counts = {}
            for age in df['age'].unique():
                condition_counts[age] = len(df.loc[(df[condition_column] == condition_value) & (df['age'] == age)])

            return condition_counts

        except Exception as e:
            print(f"An error occurred: {str(e)}")
            return None
    ```

  - _Unit test_:
  - ```python
    def test_count_condition_by_age():
        data = {
            'patient_id': [1, 2, 3, 4, 5, 6],
            'age': [25, 25, 30, 30, 35, 35],
            'condition': ['healthy', 'sick', 'healthy', 'sick', 'healthy', 'sick']
        }

        df = pd.DataFrame(data)

        condition_counts = count_condition_by_age(df, 'condition', 'sick')

        assert condition_counts == {25: 1, 30: 1, 35: 1}

    test_count_condition_by_age()
    ```

- **While loops**: #While_loops keep executing a block of code as long as a certain condition is true. Think of it as listening to your favorite song on repeat, while you're still enjoing them (condition is true).

  - _Function_: calculate_length_of_stay
  - _Purpose_: To calculate the length of stay for each patient in a dataset based on the admit and discharge date
  - _Existed functions_: pandas.DataFrame.iterrows, pandas.to_datetime
  - ```python
    import pandas as pd

    def calculate_length_of_stay(df):
        try:
            if 'admit_date' not in df.columns or 'discharge_date' not in df.columns:
                raise ValueError("Both 'admit_date' and 'discharge_date' should be in dataframe")

            df['admit_date'] = pd.to_datetime(df['admit_date'])
            df['discharge_date'] = pd.to_datetime(df['discharge_date'])

            length_of_stay = {}

            for index, row in df.iterrows():
                stay = (row['discharge_date'] - row['admit_date']).days
                if stay < 0:
                    print(f"Patient {row['patient_id']} has negative length of stay. Skipping...")
                    continue
                length_of_stay[row['patient_id']] = stay

            return length_of_stay

        except Exception as e:
            print(f"An error occurred: {str(e)}")
            return None
    ```

  - _Unit test:_
  - ```python
    def test_calculate_length_of_stay():
        data = {
            'patient_id': [1, 2, 3],
            'admit_date': ['2023-07-01', '2023-07-02', '2023-07-03'],
            'discharge_date': ['2023-07-10', '2023-07-12', '2023-07-05']
        }

        df = pd.DataFrame(data)

        length_of_stay = calculate_length_of_stay(df)

        assert length_of_stay == {1: 9, 2: 10, 3: 2}

    test_calculate_length_of_stay()
    ```

## **3. Libraries:**

- **Pandas:** #Pandas is a library used for data manipulation and analysis. It's like a powerful Excel sheet in Python. It offers data structures and operations for manipulating numerical tables and time series.
- **NumPy:** #NumPy (Numerical Python) is a library used for working with arrays. It also has functions for working in the domain of linear algebra, fourier transform, and matrices. Think of it as a math whiz-kid who can crunch large numbers and data faster and more efficiently.
- **Matplotlib:**
  Matplotlib is used for creating static, interactive, and animated visualizations in Python. Think of it as a canvas where you can paint various kinds of graphs to make sense of your data visually.
- **Seaborn:**
  Seaborn is based on Matplotlib and provides a high-level interface for drawing attractive and informative statistical graphics. It's like the stylish sibling of Matplotlib with better looking and easy-to-create plots.
- **SciPy:**
  SciPy is used for scientific computing. It builds on NumPy and provides a large number of functions that operate on NumPy arrays and are useful for different types of scientific and engineering applications. Imagine it as a toolbox that an engineer or scientist might use.
- **Scikit-learn:**
  Scikit-learn is used for machine learning. It provides simple and efficient tools for data mining and data analysis. It's like your personal robot assistant who can quickly and efficiently learn from data.
- **TensorFlow/PyTorch:**
  These are powerful libraries for creating deep learning models. They provide a flexible and efficient way of defining and computing complex mathematical expressions. Consider them as your high-tech gym equipment, but instead of building muscles, you're building and training neural networks.
- **Flask/Django:**
  Flask and Django are used for web development. Flask is a lightweight web server gateway interface (WSGI) web application framework. Django is a high-level Python web framework that enables rapid development of secure and maintainable websites. They're like the blueprint and building blocks for constructing a web application.
- **Requests:**
  Requests is a simple and elegant library to make HTTP requests. It abstracts the complexities of making requests behind a beautiful, simple API, allowing you to send HTTP/1.1 requests. Think of it as your postman who can deliver and fetch packages (in this case, data) to and from different locations.
