# Following ModernStatisticswithR.com

library(ggplot2)

###############################
#########  CHAPTER 2  #########
###############################

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
ggplot(diamonds, aes(carat, price, colour = cut, shape = cut)) +
  geom_point(alpha = 0.25) +
  xlab("Weight of diamond (carat)") +
  ylab("Price (USD)")

# 2. Then change it so that the size of each point is determined by the diamond's length, i.e. the variable x.
ggplot(diamonds, aes(carat, price, colour = cut,
                     shape = cut, size = x)) +
  geom_point(alpha = 0.25) +
  xlab("Weight of diamond (carat)") +
  ylab("Price (USD)")

# Exercise 2.14 Using the msleep data, create a plot of log-transformed body weight versus log-transformed brain weight. Use total sleep time to set the colors of the points. Change the text on the axes to something informative.
ggplot(msleep, aes(bodywt, brainwt, color = sleep_total)) +
  geom_point() +
  xlab("Body Weight (logarithmic scale)") +
  ylab("Brain Weight (logarithmic scale)") +
  scale_x_log10() +
  scale_y_log10()

# Exercise 2.15 Using the diamonds data, do the following:
# 1. Create a scatterplot with 'carat' along the x-axis and price along the y-axis, facetted by cut
ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  xlab("Carat") +
  ylab("Price (USD)") +
  facet_wrap(~ cut)
# 2. Read the documentation for facet_wrap (?facet_wrap). How can you change the number of rows in the grid plot? Create the same plot as in part 1, but with 5 rows.
?facet_wrap
# you can change the number of rows in the grid plot with the argument 'nrow = '
ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  xlab("Carat") +
  ylab("Price (USD)") +
  facet_wrap(~ cut, nrow = 5)

# Exercise 2.16 Using the 'diamonds' data, do the following:
# 1. Create boxplots of diamond prices, grouped by 'cut'
ggplot(diamonds, aes(cut, price)) +
  geom_boxplot()
# 2. Read the documentation for geom_boxplot. How can you change the colors of the boxes and their outlines?
?geom_boxplot()
# changing color is 'color = "red"' and changing the fill is 'fill = "blue"'
ggplot(diamonds, aes(cut, price)) +
  geom_boxplot(color = "blue", fill = "skyblue")
# 3. Replace 'cut' by 'reorder(cut, price, median)' in the plot's aesthetics. What does 'reorder' do? What is the result?
ggplot(diamonds, aes(reorder(cut, price, median), price)) + # changes the order of the 'cut' categories based on their median price values
  geom_boxplot()
# 4. Add 'geom_jitter(size = 0.1, alpha = 0.2)' to the plot. What happens?
ggplot(diamonds, aes(cut, price)) +
  geom_boxplot() +
  geom_jitter(size = 0.1, alpha = 0.2) # it also plots the individual observations on top of the histogram (aka showing many individual dots too)

# Exercise 2.17 Using the 'diamonds' data, do the following:
# 1. Create a histogram of diamond prices
ggplot(diamonds, aes(price)) +
  geom_histogram()
# 2. Create histograms of diamond prices for different cuts, using facetting
ggplot(diamonds, aes(price)) +
  geom_histogram() +
  facet_wrap(~ cut)
# 2. Add a suitable argument to 'geom_histogram' to add black outlines around the bars
?geom_histogram
ggplot(diamonds, aes(price)) +
  geom_histogram(color = "black") # adding 'color' and/or 'linewidth' can change the outlines around the bars

# Exercise 2.18 Using the 'diamonds' data, do the following:
# 1. Create a bar chart of diamond cuts
ggplot(diamonds, aes(cut)) +
  geom_bar()
# 2. Add different colors to the bars by adding a 'fill' argument to 'geom_bar'
ggplot(diamonds, aes(cut)) +
  geom_bar(fill = c("blue", "gold", "red", "green", "orange")) # this is to manually assign colors

ggplot(diamonds, aes(cut, fill = cut)) + # this will auto assign the colors to the bars
  geom_bar() 
# 3. Check the documentation for 'geom_bar'. How can you decrease the width of the bars?
?geom_bar
# 'linewidth' changes the width of the bars
ggplot(diamonds, aes(cut, fill = cut)) +
  geom_bar(color = "black", linewidth = 1)
# 4. Return to the code you used for part 1. Add fill = clarity to the aes. What happens?
ggplot(diamonds, aes(cut, fill = clarity)) + # this changes the fill to break it down by the clarity category within each bar
  geom_bar()
# 5. Next, add 'position = "dodge" to 'geom_bar'. What happens?
ggplot(diamonds, aes(cut, fill = clarity)) +
  geom_bar(position = "dodge") # instead of stacking the 'clarity' by cut it creates different individual bar graphs for the clarity groups by cut
# 6. Return to the code you used for part 1. Add coord_flip() to the plot. What happens?
ggplot(diamonds, aes(cut)) +
  geom_bar() +
  coord_flip() # this flips the bar graphs from going vertical to horizontal

# Exercise 2.19 Do the following:
# 1. Create a plot object and save it as a 4 by 4 inch png file
diamond_cuts_by_clarity <- ggplot(diamonds, aes(cut, fill = clarity)) +
  geom_bar(position = "dodge")
diamond_cuts_by_clarity
ggsave("diamond_cut_by_clarity.png", diamond_cuts_by_clarity, width = 4, height = 4)
# 2. When preparing images for print, you may want to increase their resolution. Check the documentation for ggsave. How can you increase the resolution of your png file for 600 dpi?
?ggsave
# changing the resolution is 'dpi'
ggsave("diamond_cuts_by_clarity.png", diamond_cuts_by_clarity, width = 4, height = 4, dpi = 600)


###############################
#########  CHAPTER 3  #########
###############################

# Exercise 3.1 The following tasks are all related to data types and data structures:
# 1. Create a text variable using e.g. a <- "A rainy day in Edinburgh". Check that it gets the correct type. What happens if you use single quotes markes instead of double quotes when you create the variable?
a <- "A rainy day in Edinburgh"
class(a) # result: character
b <- 'A rainy day in Edinburgh' # single quotes don't make a difference
class(b) # result: character
# 2. What data types are the sums 1 + 2, 1L + 2 and 1L + 2L?
c <- 1 + 2 # result: 3
class(c) # numeric
d <- 1L + 2 # result: 3
class(d) # numeric
e <- 1L + 2L # result: 3L
class(d) # numeric
# 3. What happens if you add a numeric to a character, e.g. "Hello" + 1?
f <- "Hello" + 1 # Error: non-numeric argument to binary operator
# 4. What happens if you perform mathematical operations involving a numeric and a logical, e.g. FALSE * 2 or TRUE + 1?
g <- FALSE * 2
print(g) # result: 0
class(g) # result: numeric
h <- TRUE + 1
print(h) # result: 2
class(h) # result: numeric

# Exercise 3.2 What do the functions 'ncol', 'nrow', 'dim', 'names', and 'row.names' return when applied to a data frame?
ncol(msleep) # result: 11; shows the number of columns in the data frame
nrow(msleep) # result: 83: shows the number of rows in the data frame
dim(msleep) # result: 83 11; shows the dimensions of the data frame so 83 rows and 11 columns
names(msleep) # result: "name" "genus" "vore", etc.; shows the names of the columns
row.names(msleep) # result: "1" "2" "3", etc.; shows the names of the rows (aka the first value of the row)

# Exercise 3.3 'matrix' tables can be created from vectors using the function of the same name. Using the vector x <- 1:6 use matrix to create the following matrices:
?matrix
x <- 1:6
matrix(x, nrow = 2, ncol = 3, byrow = TRUE)
#     [,1] [,2] [,3]
# [1,]  1    2    3
# [2,]  4    5    6
matrix(x, nrow = 3, ncol = 2, byrow = FALSE)
#       [,1] [,2]
# [1,]    1    4
# [2,]    2    5
# [3,]    3    6

# Exercise 3.4 The following tasks all involve using the [i, j] notation for extracting data from data frames: 
# 1. Why does airquality[,3] not return the third row of airquality?
airquality[,3] # this will instead return the 3rd column of data
# 2. Extract the first five rows from airquality. Hint: a fast way of creating the vector c(1, 2, 3, 4, 5) is to write 1:5
airquality[c(1:5),]
# 3. Compute the correlation between the Temp and Wind vectors of airquality without referring to them using $
names(airquality) # Wind is the 3rd column and Temp is the 4th columns
cor(airquality[,4],airquality[,3])
cor(airquality[,"Wind"], airquality[,"Temp"]) # can also use the actual names of the columns too
# 4. Extract all columns from airquality except Temp and Wind.
airquality[,c(-3,-4)]

# Exercise 3.5 Use the bookstore data frame to do the following:
age <- c(28, 48, 47, 71, 22, 80, 48, 30, 31)
purchase <- c(20, 59, 2, 12, 22, 160, 34, 34, 29)
bookstore <- data.frame(age, purchase)
bookstore$visit_length <- c(5, 2, 20, 22, 12, 31, 9, 10, 11)
bookstore
# 1. Add a new variable 'rev_per_minute' which is the ratio between purchase and the visit length
bookstore$rev_per_minute <- (bookstore$purchase / bookstore$visit_length)
bookstore
# 2. Oh no, there's been an error in the data entry! Replace the purchase amount for the 80-year old customer with 16
bookstore$purchase[6] <- 16
bookstore

# Exercise 3.6 The following tasks all involve checking conditions for the airquality data:
?airquality
# 1. Which was the coldest day during the period?
airquality[which.min(airquality$Temp),] 
# returns:   Ozone Solar.R Wind Temp Month Day
#         5   NA    NA    14.3   56   5     5

# 2. How many days was the wind speed greater than 17 mph?
sum(airquality$Wind > 17) # returns: 3

# 3. How many missing values are there in the 'Ozone' vector?
sum(is.na(airquality$Ozone)) # returns: 37

# 4. How many days are there for which the temperature was below 70 and the wind speed was above 10?
sum(airquality$Temp < 70 & airquality$Wind > 10) # returns: 22

# Exercise 3.7 The function 'cut' can be used to create a categorical variable from a numerical variable, by dividing it into categories corresponding to different intervals. Read its documentation and then create a new categorical variable in the airquality data, TempCat, which divides Temp into the three intervals (50, 70], (70, 90], (90, 110].
?cut
airquality$TempCat <- cut(airquality$Temp,
                          breaks = c(50, 70, 90, 110))
airquality






