# Following ModernStatisticswithR.com

library(ggplot2)

###############################
#########  CHAPTER 2  #########
###############################

msleep # sample data set that comes built in with 'ggplot2'
View(msleep) # this will show the table of values in a separate window that is easier to read

head(msleep) # returns the top of the table
tail(msleep) # returns the bottom of the table
dim(msleep) # returns the number of rows and columns of the data frame
str(msleep) # returns information about the variables (chr, num, ex.)
names(msleep) # returns a vector containing the names of the variables
?msleep # returns the documentation available on the data set
data(msleep) # this turns the data set into a variable in the Environment

### Numerical Data ###
summary(msleep) # gives a descriptive statistics summary of each variable in the dataset
msleep$sleep_total # to access a particular vector inside a dataframe, use the dollar sign

# examples of important functions that can be used to compute descriptive statistics
mean(msleep$sleep_total) # Mean
median(msleep$sleep_total) # Median
max(msleep$sleep_total) # Max
min(msleep$sleep_total) # Min
sd(msleep$sleep_total) # Standard Deviation
var(msleep$sleep_total) # Variance
quantile(msleep$sleep_total) # Various quantiles

# Additional arithmetic operators
abs(x) # computes the absolute value |x|.
sqrt(x) # computes √x.
log(x) # computes the logarithm of x with the natural number e as the base.
log(x, base = a) # computes the logarithm of x with the number a as the base.
a^x # computes ax.
exp(x) # computes ex.
sin(x) # computes sin(x).
sum(x) # when x is a vector x = (x1, x2, x3, …, xn), computes the sum of the elements of x: ∑ni= 1xi.
prod(x) # when x is a vector x = (x1, x2, x3, …, xn), computes the product of the elements of x: ∏ni= 1xi.
pi # a built-in variable with value π, the ratio of the circumference of a circle to its diameter.
x %% a # computes x modulo a.
factorial(x) # computes x!.
choose(n, k) # computes (nk).

cor(msleep$sleep_total, msleep$sleep_rem, use = "complete.obs") # calculates the correlation between the two variables
# "complete.obs" tells it to compute the correlation using only observations with complete data (i.e. no missing values)

na.rm <- TRUE # used in functions to ignore the NA or blank values

### Categorical Data ###
table(msleep$vore) # this shows the frequency count of the values in the column
proportions(table(msleep$vore)) # this will show the proportion of the values in the column (ex: 0.25, 0.42, 0.06, 0.26 = 100%)

# Counts:
table(msleep$vore, msleep$conservation)

# Proportions, per row:
proportions(table(msleep$vore, msleep$conservation),
  margin = 1
)

# Proportions, per column:
proportions(table(msleep$vore, msleep$conservation),
  margin = 2
)

### Plotting Data ###
plot(msleep$sleep_total, msleep$sleep_rem) # the most basic built in version of plotting data

ggplot(msleep, aes(x = sleep_total, y = sleep_rem)) +
  geom_point()
# the three main components of this are:
# - Data: given by the first argument in the call to ggplot: msleep
# - Aesthetics: given by the second argument in the ggplot call: aes, where we map sleep_total to the x-axis and sleep_rem to the y-axis
# - Geoms: given by geom_point, meaning that the observations will be represented by points

plot(msleep$sleep_total, msleep$sleep_rem, pch = 16)
grid()
ggplot(msleep, aes(sleep_total, sleep_rem)) +
  geom_point()

# Colors, shapes, and axis labels
ggplot(msleep, aes(sleep_total, sleep_rem)) +
  geom_point(color = "red") + # this turns all points into one color
  xlab("Total sleep time (h)")

colors() # this will generate a list of all available color options

ggplot(msleep, aes(sleep_total, sleep_rem, color = vore)) + # this sets each category with its own color value for the points
  geom_point() +
  xlab("Total sleep time (h)")

ggplot(msleep, aes(sleep_total, sleep_rem, color = sleep_cycle)) + # since 'sleep_cycle' is on a numeric scale, the color is scaled from light blue to dark blue depending on the value
  geom_point() +
  xlab("Total sleep time (h)")

# Axis limits and scales
ggplot(msleep, aes(brainwt, sleep_total, color = vore)) +
  geom_point() +
  xlab("Brain weight") +
  ylab("Total sleep time") +
  xlim(0, 1.5) # if there are outliers that make the rest of the graph not readable, you can limit the axis

ggplot(msleep, aes(log(brainwt), sleep_total, color = vore)) + # using the log transformation can also make the graph easier to read
  geom_point() +
  xlab("log(Brain Weight)") +
  ylab("Total sleep time")

ggplot(msleep, aes(brainwt, sleep_total, color = vore)) +
  geom_point() +
  xlab("Brain Weight (logarithmic scale)") +
  ylab("Total sleep time") +
  scale_x_log10() # this changes the scale of the x-axis to a log10 scale (which increases interpretability because the values shown at the ticks still are on the original x-scale).

# Comparing Groups
ggplot(msleep, aes(brainwt, sleep_total)) +
  geom_point() +
  xlab("Brain weight (logarithmic scale)") +
  ylab("Total sleep time") +
  scale_x_log10() +
  facet_wrap(~vore) # this uses 'facetting' which is to create a grid of plots corresponding to the different groups
# this makes it easier to compare the different groups all at one glance

# Boxplots
# Base R:
boxplot(sleep_total ~ vore, data = msleep)
# ggplot2:
ggplot(msleep, aes(vore, sleep_total)) +
  geom_boxplot()

# Histograms
# Base R:
hist(msleep$sleep_total)
# ggplot2:
ggplot(msleep, aes(sleep_total)) +
  geom_histogram()

### Plotting Categorical Data ###
# Bar charts
# Base R:
barplot(table(msleep$vore))
# ggplot2:
ggplot(msleep, aes(vore)) +
  geom_bar()

ggplot(msleep, aes(factor(1), fill = vore)) + # the fill adds different colors depending on the categories
  geom_bar()

### Saving Your Plot ###
library(ggplot2)
myPlot <- ggplot(msleep, aes(sleep_total, sleep_rem)) +
  geom_point()
myPlot # now just to plot the object, you would just have to call its name
myPlot + xlab("I forgot to add a label!") # you can also still add things once its been named

ggsave("filename.pdf", myPlot, width = 5, height = 5) # this is to save the plot as a file and to specify the size


###############################
#########  CHAPTER 3  #########
###############################

# Transforming, summarising, and analyzing data
# Types and Structures
# 6 Basic Data Types in R
# 1. numeric: numbers like 1 and 16.823 (sometimes also called double)
# 2. logical: true/false values (boolean): either TRUE or FALSE
# 3. character: text, e.g. "a", "Hello! I'm Ada." and "name@domain.com"
# 4. integer: integer numbers, denoted in R by the letter L: 1L, 55L
# 5. complex: complex numbers like 2+3i. Rarely used in statistical work
# 6. raw: used to hold raw bytes

x <- 6
y <- "Scotland"
z <- TRUE

class(x) # result: numeric
class(y) # result: character
class(z) # result: logical
# class() is used to check what datatype a variable is

numbers <- c(6, 9, 12)
class(numbers) # returns: numeric

all_together <- c(x, y, z)
all_together
class(all_together) # changes the class to all values in the vector to "character"
# R will coerce the objects in a vector to all be of the same type

# Types of Tables
# There are four main types:
# 1. matrix: a table where all columns must contain objects of the same type (e.g. all numeric or all character). Uses less memory than other types and allows for much faster computations, but is difficult to use for certain types of data manipulation, plotting and analysis
# 2. data.frame: the most common type, where different columns can contain different types (e.g. one numeric column, one character column)
# 3. data.table: an enhanced version of data.frame
# 4. tbl_df ("tibble"): another enhanced version of data.frame

# First, an example of data stored in a matrix:
?WorldPhones
class(WorldPhones) # "matrix" "array"
View(WorldPhones)

# Next, an example of data stored in a data frame:
?airquality
class(airquality) # "data.frame"
View(airquality)

# Finally, an example of data stored in a tibble:
library(ggplot2)
?msleep
class(msleep)
View(msleep)

WorldPhonesDF <- as.data.frame(WorldPhones) # sometimes you need to convert to other types so this is how you would do it
class(WorldPhonesDF) 
airqualityMatrix <- as.matrix(airquality)
class(airqualityMatrix)

# Accessing vectors and elements
# Extract the Temp vector: 
airquality$Temp
# Compute the mean temperature:
mean(airquality$Temp)
# and to access a specific element within the vector you use square brackets for the index
airquality$Temp[5]

# Using the Dollar Sign
# $ can not just extract data from a data frame but also manipulate it
age <- c(28, 48, 47, 71, 22, 80, 48, 30, 31)
purchase <- c(20, 59, 2, 12, 22, 160, 34, 34, 29)
bookstore <- data.frame(age, purchase)

bookstore$age[2] <- 18 # this will change a singular value in the data frame
# or
bookstore[2, 1] <- 18

bookstore$age <- bookstore$age * 12
bookstore$age

bookstore$visit_length <- c(5, 2, 20, 22, 12, 31, 9, 10, 11) # as long as the row count matches, this will add a whole new column to the data frame
bookstore

# Using Conditions
max(airquality$Temp) # this will return the highest value just for that specific column of values
which.max(airquality$Temp) # 'which.max' returns the index of the observation with the maximum value
# if you want to see that entire row:
airquality[120,]
airquality[which.max(airquality$Temp),] # this is the way to do it all in one function without knowing which is the max index already

# operators when stating conditions
a <- 3
b <- 8

a == b   # check if a equals b
a > b    # check if a is greater than b
a < b    # check if a is less than b
a >= b   # check if a is equal to or greater than b
a <= b   # check if a is equal to or less than b
a != b   # check if a is not equal to b
is.na(a) # check if a is NA
A %in% c(1, 4, 9) # Check if a equals at least on of 1, 4, 9

which(airquality$Temp > 90) # 'which' gets the indices of the elements that fulfill the condition
all(airquality$Temp > 90) # 'all' is used to see if all elements in a vector fulfill the condition
any(airquality$Temp > 90) # 'any' is used to see if any elements in a vector fulfill the condition
sum(airquality$Temp > 90) # used to find out how many elements fulfill the condition
mean(airquality$Temp > 90) # will return the mean for all the elements that fulfill the condition

# Additional operators & (AND), | (OR), and, less frequently, xor (exclusively or, XOR). 
a <- 3
b <- 8

# Is a less than b and greater than 1?
a < b & a > 1 # TRUE

# Is a less than b and equal to 4?
a < b & a == 4 # FALSE

# Is a less than b and/or equal to 4?
a < b | a == 4 # TRUE

# Is a equal to 4 and/or equal to 5?
a == 4 | a == 5 # FALSE

# Is a less than b XOR equal to 4?
# I.e. is one and only one of these satisfied?
xor(a < b, a == 4) # TRUE















