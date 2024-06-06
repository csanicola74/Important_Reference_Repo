# Following ModernStatisticswithR.com

library(ggplot2)

# Exercise 2.1
# Exercise 2.1 Use R to compute the product of the first ten integers: 1,2,3,4,5,6,7,8,9,10
1+2+3+4+5+6+7+8+9+10

# Exercise 2.2
# Exercise 2.2 Do the following using R:
  # Compute the sum 924 + 124 and assign the result to a variable named a.
  # Compute a⋅a.
a <- 924 + 124
a
a * a

# Exercise 2.3
income <- 100
taxes <- 20
# 1. What happens if you use an invalid character in a variable name? Try e.g. the following:
net income <- income - taxes # get 'Error: unexpected symbol in "net income"
net-income <- income - taxes # get 'Error: object 'net' not found
ca$h <- income - taxes # get 'Error: object 'ca' not found

# 2. What happens if you put R code as a comment? E.g.:
income <- 100
taxes <- 20
net_income <- income - taxes
# gross_income <- net_income + taxes 
# -> by commenting out the last part, the function does not run

# 3. What happens if you remove a line break and replace it by a semicolon ; ? E.g.:
income <- 200; taxes <- 30 # semicolons can be used to write multiple commands on a single line - both will run as if they were on separate lines

# 4. What happens if you do two assignments on the same line? E.g.:
income2 <- taxes2 <- 100 # the value to the right is assigned to both variables
# however, any operations you perform on one variable won't affect the other; for ex: if you change the value of one of them, the other will remain unchanged


# Exercise 2.4 Do the following:
# 1. Create two vectors, height and weight, containing the heights and weights of five fictional people (i.e. just make up some numbers)
height <- c(60.5, 62.8, 65, 72.3, 70.1)
weight <- c(210, 175, 340, 112, 183)
height_weight <- data.frame(height, weight) # using the 'data.frame' combines vectors into a data frame
height_weight

# Exercise 2.5 Try creating a vector using x <- 1:5. What happens? What happens if you use 5:1 instead? How can you use this notation to create the vector (1,2,3,4,5,4,3,2,1)?
x <- 1:5 # creates a vector of [1, 2, 3, 4, 5]
x
x2 <- 5:1 # does the same but creates it in reverse [5, 4, 3, 2, 1]
x2
x3 <- c(1:5, 4:1) # this will combine the 1 through 5 and then go reverse for the 4 to 1
x3

# Exercise 2.6 Using the data you created in Exercise 2.4, do the following:
# 1. Compute the mean height of the people
mean(height) # answer: 66.14
# 2. Compute the correlation between height and weight
cor(height,weight) # answer: -0.4459102 (indicating a negative correlation between the height and weight)

# Exercise 2.7 Do the following
# 1. Read the documentation for the function 'length'. What does it do? Apply it to your 'height' vector.
?length # "Get or set the length of vectors (including lists) and factors, and of any other R object for which a method has been defined."
length(height) # returns '5' because there are 5 values in the vector
# 2. Read the documentation for the function 'sort'. What does it do? What does the argument 'decreasing' (the values of which can be either FALSE or TRUE) do? Apply the function to your 'weight' vector.
?sort # "Sort (or order) a vector or factor (partially) into ascending or descending order. For ordering along more than one variable, e.g., for sorting data frames, see order."
# decreasing: logical. Should the sort be increasing or decreasing? Not available for partial sorting.
sort(weight) # returns it in order [112, 175, 183, 210, 340]

# Exercise 2.8 Compute the following:
# 1. √π
sqrt(pi) # returns 1.772454
# 2. e2 ⋅ log(4)
exp(2) * log(4) # returns 10.24341

# Exercise 2.9 R will return non-numerical answers if you try to perform computations where the answer is infinite or undefined. Try the following to see some possible results:
# 1. Compute 1/0
1/0 # returns 'Inf'
# 2. Compute 0/0
0/0 # returns 'NaN'
# 3. Compute √-1
sqrt(-1) # returns 'NaN' and 'Warning message: In sqrt(-1): NaNs produced

# Exercise 2.10 Load ggplot2 using library(ggplot2) if you have not already done so. Then do the following:
library(ggplot2)
# 1. View the documentation for the 'diamonds' data and read about the different variables
?diamonds # a dataset containing the prices and other attributes of almost 54,000 diamonds
# The variables are as follows:
# 1. price - price in US dollars ($326–$18,823)
# 2. carat - weight of the diamond (0.2–5.01)
# 3. cut - quality of the cut (Fair, Good, Very Good, Premium, Ideal)
# 4. color - diamond colour, from D (best) to J (worst)
# 5. clarity - a measurement of how clear the diamond is (I1 (worst), SI2, SI1, VS2, VS1, VVS2, VVS1, IF (best))
# 6. x - length in mm (0–10.74)
# 7. y - width in mm (0–58.9)
# 8. z - depth in mm (0–31.8)
# 10. depth - total depth percentage = z / mean(x, y) = 2 * z / (x + y) (43–79)
# 11. table - width of top of diamond relative to widest point (43–95)

# 2. Check the data structures: how many observations and variables are there and what type of variables (numeric, categorical, etc.) are there?
View(diamonds)
head(diamonds)
tail(diamonds)
dim(diamonds)
str(diamonds)
  # from this we can see there are 6 num variables, 1 int variable, and 3 categorical (Ord.factor) variables
names(diamonds)
data(diamonds)

# 3. Compute summary statistics (means, median, min, max, counts for categorical variables). Are there any missing values?
summary(diamonds)

# Exercise 2.11 Create a scatterplot with total sleeping time along the x-axis and time awake along the y-axis (using the msleep data). What pattern do you see? Can you explain it?
?msleep
data(msleep)
ggplot(msleep, aes(sleep_total, awake)) + 
  geom_point()
# the data shows an inverse relationship (straight line across and down) between the time awake and the total sleep time

# Exercise 2.12 Using the diamonds data, do the following:
# 1. Create a scatterplot with carat along the x-axis and price along the y-axis. Change the x-axis label to read "Weight of the diamond (carat)" and the y-axis label to "Price (USD)." Use cut to set the color of the points.
ggplot(diamonds, aes(carat, price, color = cut)) +
  geom_point() +
  xlab("Weight of the diamond (carat)") +
  ylab("Price (USD)")

#. 2. Try adding the argument alpha = 1 to geom_point, i.e., geom_point(alpha = 1). Does anything happen? Try changing the 1 to 0.5 and 0.25 and see how that affects the plot.
ggplot(diamonds, aes(carat, price, color = cut)) +
  geom_point(alpha = 0.25) + # changing the alpha changes the opacity of the points (making them darker versus more transparent)
  xlab("Weight of the diamond (carat)") +
  ylab("Price (USD)")

# Exercise 2.13 Similar to how you changed the color of the points, you can also change their size and shape. The arguments for this are called 'size' and 'shape'
# 1. Change the scatterplot from Exercise 2.12 so that diamonds with different cut qualities are represented by different shapes
?shape
# Shape examples
# p + geom_point()
# p + geom_point(shape = 5)
# p + geom_point(shape = "k", size = 3)
# p + geom_point(shape = ".")
# p + geom_point(shape = NA)
# p + geom_point(aes(shape = factor(cyl)))
ggplot(diamonds, aes(carat, price, color = cut, shape = cut)) +
  geom_point(alpha = 0.5) + # this made the points smaller and changed their shape to diamond
  xlab("Weight of the diamond (carat)") +
  ylab("Price (USD)")

# 2. Then change it so that the size of each point is determined by the diamond's length, i.e. the variable x.
ggplot(diamonds, aes(carat, price, color = cut, shape = cut, size = x)) +
  geom_point(alpha = 0.25) +
  xlab("Weight of the diamond (carat)") +
  ylab("Price (USD)")












