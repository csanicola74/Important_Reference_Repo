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
airquality[120, ]
airquality[which.max(airquality$Temp), ] # this is the way to do it all in one function without knowing which is the max index already

# operators when stating conditions
a <- 3
b <- 8

a == b # check if a equals b
a > b # check if a is greater than b
a < b # check if a is less than b
a >= b # check if a is equal to or greater than b
a <= b # check if a is equal to or less than b
a != b # check if a is not equal to b
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

# Importing Data
imported_data <- read.csv("philosophers.csv") # this will only work if the file is in your working directory
imported_data2 <- read.csv(file.choose()) # this will allow you to select a file not in your working directory

# File Paths
# or you can specify a file path and use that
# Windows example 1:
file_path <- "C:/Users/Mans/Desktop/MyData/philosophers.csv"
# Windows example 2:
file_path <- "C:\\Users\\Mans\\Desktop\\MyData\\philosophers.csv"
imported_data <- read.csv(file.path) # then you would call the variable 'file_path' when you want to import it

# Importing Excel Files
install.packages("openxlsx")
library(openxlsx)
imported_from_Excel <- read.xlsx(file_path)

# Exporting Data
# Bookstore example
age <- c(28, 48, 47, 71, 22, 80, 48, 30, 31)
purchase <- c(20, 59, 2, 12, 22, 160, 34, 34, 29)
bookstore <- data.frame(age, purchase)

# Export to .csv:
write.csv(bookstore, "bookstore.csv")

# Export to .xlsx (Excel):
library(openxlsx)
write.xlsx(bookstore, "bookstore.xlsx")

# Saving and Loading R Data
save(bookstore, age, file = "myData.RData") # saves just the objects bookstore and age
save.image(file = "allMyData.RData") # to save all objects in your environment
load(file = "myData.RData") # loading the stored objects

# Running a t-test
library(ggplot2)
carnivores <- msleep[msleep$vore == "carni", ]
herbivores <- msleep[msleep$vore == "herbi", ]
t.test(carnivores$sleep_total, herbivores$sleep_total)

t.test(carnivores$sleep_total, herbivores$sleep_total,
  conf.level = 0.90, # this sets the confidence level to 90%
  alternative = "greater", # to use a one-sided alternative hypothesis
  var.equal = TRUE
) # performs the test under the assumption of equal variances in the two samples

# Fitting a linear regression model
?mtcars
View(mtcars)

library(ggplot2)
ggplot(mtcars, aes(hp, mpg)) + # to see the relationship between horsepower (hp) and fuel consumption (mpg)
  geom_point()

m <- lm(mpg ~ hp, data = mtcars) # using linear regression to fit the model
summary(m)
# OUTPUT:
# Call:
#   lm(formula = mpg ~ hp, data = mtcars)
#
# Residuals:
#   Min      1Q  Median      3Q     Max
# -5.7121 -2.1122 -0.8854  1.5819  8.2360
#
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)
# (Intercept) 30.09886    1.63392  18.421  < 2e-16 ***
#   hp          -0.06823    0.01012  -6.742 1.79e-07 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
# Residual standard error: 3.863 on 30 degrees of freedom
# Multiple R-squared:  0.6024,	Adjusted R-squared:  0.5892
# F-statistic: 45.46 on 1 and 30 DF,  p-value: 1.788e-07

# Check model coefficients:
coef(m)

# Add regression line to plot:
ggplot(mtcars, aes(hp, mpg)) +
  geom_point() +
  geom_abline(aes(intercept = coef(m)[1], slope = coef(m)[2]), # to add a straight line with a given intercept and slope
    color = "red"
  )
plot(m) # to see the diagnostic plots for the residuals

m2 <- lm(mpg ~ hp + wt, data = mtcars)
summary(m2)

# Grouped Summaries
aggregate(Temp ~ Month, data = airquality, FUN = mean) # the aggregate function creates a grouped summary; this is getting the mean temperature for each month

aggregate(Ozone ~ Month, data = airquality, FUN = mean) # even though the Ozone column contains NA, by default aggregate removes NA before computing the grouped summaries

aggregate(cbind(Temp, Wind) ~ Month, data = airquality, FUN = sd) # this way you can compute multiple variables at the same time; for this its the standard deviation of Temp and Wind

aggregate(Temp ~ Month, data = airquality, FUN = length) # this counts the number of observations in the groups; this for example is counting the number of days in each month

by(airquality$Temp, airquality$Month, mean) # another method to get grouped summaries but with a nicer output format:
# airquality$Month: 5
# [1] 65.54839
# --------------------------------------------------------------------------------------------------------------------------
#   airquality$Month: 6
# [1] 79.1
# --------------------------------------------------------------------------------------------------------------------------
#   airquality$Month: 7
# [1] 83.90323
# --------------------------------------------------------------------------------------------------------------------------
#   airquality$Month: 8
# [1] 83.96774
# --------------------------------------------------------------------------------------------------------------------------
#   airquality$Month: 9
# [1] 76.9

names(airquality) # Check that Wind and Temp are in columns 3 and 4
by(airquality[, 3:4], airquality$Month, cor)
# OUTPUT:
# airquality$Month: 5
# Wind      Temp
# Wind  1.000000 -0.373276
# Temp -0.373276  1.000000
# --------------------------------------------------------------------------------------------------------------------------
#   airquality$Month: 6
# Wind       Temp
# Wind  1.0000000 -0.1210353
# Temp -0.1210353  1.0000000
# --------------------------------------------------------------------------------------------------------------------------
#   airquality$Month: 7
# Wind       Temp
# Wind  1.0000000 -0.3052355
# Temp -0.3052355  1.0000000
# --------------------------------------------------------------------------------------------------------------------------
#   airquality$Month: 8
# Wind       Temp
# Wind  1.0000000 -0.5076146
# Temp -0.5076146  1.0000000
# --------------------------------------------------------------------------------------------------------------------------
#   airquality$Month: 9
# Wind       Temp
# Wind  1.0000000 -0.5704701
# Temp -0.5704701  1.0000000

# Using %>% Pipes
# The 'magrittr' package adds a set of tools called pipes to R
install.packages("magrittr")
library(magrittr)

# Extract hot days:
airquality2 <- airquality[airquality$Temp > 80, ]
# Convert wind speed to m/s:
airquality2$Wind <- airquality2$Wind * 0.44704
# Compute mean wind speed for each month:
hot_wind_means <- aggregate(Wind ~ Month, data = airquality2, FUN = mean)
# More compact:
hot_wind_means <- aggregate(Wind * 0.44704 ~ Month,
  data = airquality[airquality$Temp > 80, ],
  FUN = mean
)

# magrittr introduces a new operator, %>%, called a pipe, which can be used to chain functions together
# new_variable <- function_2(function_1(your_data))
# can instead be written as:
# your_data %>% function_1 %>% function_2 -> new_variable

subset(airquality, Temp > 80) # subset is a function that lets us extract the values that match the criteria
library(magrittr)
inset(airquality, "Wind", value = airquality$Wind * 0.44704) # inset lets us convert the wind speed

# So you can take these steps:
# Extract hot days:
airquality2 <- subset(airquality, Temp > 80)
# Convert wind speed to m/s
airquality2 <- inset(airquality2, "Wind",
  value = airquality2$Wind * 0.44704
)
# Compute mean wind speed for each month:
hot_wind_means <- aggregate(Wind ~ Month,
  data = airquality2,
  FUN = mean
)

# Can now be put into one code block
airquality %>%
  subset(Temp > 80) %>%
  inset("Wind", value = .$Wind * 0.44704) %>%
  aggregate(Wind ~ Month, data = ., FUN = mean) ->
hot_wind_means

# Aliases and placeholders
# Standard solution:
exp(log(2))
# magrittr solution:
2 %>%
  log() %>%
  exp()

x <- 2
exp(x + 2)
x %>%
  add(2) %>%
  exp()

# more examples:
x <- 2
# Base solution;          magrittr solution
exp(x - 2)
x %>%
  subtract(2) %>%
  exp()
exp(x * 2)
x %>%
  multiply_by(2) %>%
  exp()
exp(x / 2)
x %>%
  divide_by(2) %>%
  exp()
exp(x^2)
x %>%
  raise_to_power(2) %>%
  exp()
head(airquality[, 1:4])
airquality %>%
  extract(, 1:4) %>%
  head()
airquality$Temp[1:5]
airquality %>%
  use_series(Temp) %>%
  extract(1:5)

cat(paste("The current time is ", Sys.time()))
Sys.time() %>%
  paste("The current time is", .) %>%
  cat() # the '.' can be used as a placeholder

airquality %>% cat("Number of rows in data:", nrow(.)) # Doesn't work
airquality %>%
  {
    cat("Number of rows in data:", nrow(.))
  } # Works!
# if the data only appears inside parentheses, you need to wrap the function in curly brackets {}, or otherwise %>% will try to pass it as the first arguement to the function

###############################
#########  CHAPTER 4  #########
###############################

# SKIPPIED THE MARKDOWN SECTION

# Customizing ggplot2 plots
library(ggplot2)

ggplot(msleep, aes(brainwt, sleep_total)) +
  geom_point() +
  xlab("Brain weight (logarithmic scale)") +
  ylab("Total sleep time") +
  scale_x_log10() +
  facet_wrap(~vore)

# Themes
# ggplot2 comes with a number of basic themes
p <- ggplot(msleep, aes(brainwt, sleep_total, color = vore)) +
  geom_point() +
  xlab("Brain weight (logarithmic scale)") +
  ylab("Total sleep time") +
  scale_x_log10() +
  facet_wrap(~vore)

# Create plot with different themes:
p + theme_grey() # the default theme
p + theme_bw()
p + theme_linedraw()
p + theme_light()
p + theme_dark()
p + theme_minimal()
p + theme_classic()

# there are also several additional themes that can be downloaded
install.packages("ggthemes")
library(ggthemes)
# create plot with different themes from ggthemes:
p + theme_tufte() # Minimalist Tufte theme
p + theme_wsj() # Wall Street Journal
p + theme_solarized() + scale_color_solarized() # Solarized colors

install.packages("hrbrthemes")
library(hrbrthemes)
# create plot with different themes from hrbrthemes:
p + theme_ipsum() # Ipsum theme
p + theme_ft_rc() # Suitable for use with dark RStudio themes
p + theme_modern_rc() # Suitable for use with dark RStudio themes

# Color palettes
# you can change the color palette using scale_color_brewer
# there are three types of color palettes available
# 1. Sequential palettes: that range from a color to white. These are useful for representing ordinal (i.e. ordered) categorical variables and numerical variables
# 2. Diverging palettes: these range from one color to another, with white in between. Diverging palettes are useful when there is a meaningful middle of 0 value (e.g. when your variables represent temperatures or profit/loss), which can be mapped to white
# 3. Qualitative palettes: which contain multiple distinct colors. These are useful for nominal (i.e. with no natural ordering) categorical variables
?scale_color_brewer # or http://www.colorbrewer2.org for the list of available palettes
# Sequential palette:
p + scale_color_brewer(palette = "OrRd")
# Diverging palette:
p + scale_color_brewer(palette = "RdBu")
# Qualitative palette:
p + scale_color_brewer(palette = "Set1")

# You can also customize the Theme settings
# No Legend:
p + theme(legend.position = "none")
# Legend below figure:
p + theme(legend.position = "bottom")
# Legend inside plot:
p + theme(legend.position = c(0.9, 0.7))

p + theme(
  panel.grid.major = element_line(color = "black"),
  panel.grid.minor = element_line(
    color = "purple",
    linetype = "dotted"
  ),
  panel.background = element_rect(color = "red", size = 2),
  plot.background = element_rect(fill = "yellow"),
  axis.text = element_text(family = "mono", color = "blue"),
  axis.title = element_text(family = "serif", size = 14)
)

# Exploring distributions
# Density plots and frequency polygons
library(ggplot2)
ggplot(diamonds, aes(carat)) +
  geom_histogram(color = "black")

ggplot(diamonds, aes(carat)) +
  geom_freqpoly() # this shows the frequency bars as lines instead

ggplot(diamonds, aes(carat, color = cut)) + # this will now not only show it as lines but stacked by color and by cut
  geom_freqpoly()

ggplot(diamonds, aes(carat, color = cut)) +
  geom_density() # this will show the lines by density (so actually stacked)

# Violin plots
ggplot(diamonds, aes(cut, price)) +
  geom_violin() # each group is represented by a "violin", given by a rotated and duplicated density plot
# compared to boxplots, violin plots capture the entire distribution of the data rather than just a few numerical summaries.
ggplot(diamonds, aes(cut, price)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) # if you want to add back in the median and quartiles, you do this

# Combine multiple plots into a single graphic
install.packages("patchwork") # this package extends ggplot2
# to use the package, you have to save each plot as an object and then add the object together
plot1 <- ggplot(diamonds, aes(cut, carat, fill = cut)) +
  geom_violin() +
  theme(legend.position = "none")
plot2 <- ggplot(diamonds, aes(cut, price, fill = cut)) +
  geom_violin() +
  theme(legend.position = "none")

library(patchwork)
plot1 + plot2

# plots can also be arranged on multiple lines with a different number of plots on each line
# separate plots that are the same line are marked by '|' and the beginning of a new line is marked with '/'
# Create two more plot objects:
plot3 <- ggplot(diamonds, aes(cut, depth, fill = cut)) +
  geom_violin() +
  theme(legend.position = "none")
plot4 <- ggplot(diamonds, aes(carat, fill = cut)) +
  geom_density(alpha = 0.5) +
  theme(legend.position = c(0.9, 0.6))

# One row with three plots and one row with a single plot:
(plot1 | plot2 | plot3) / plot4

# One column with three plots and one column with a single plot:
(plot1 / plot2 / plot3) | plot4

# Outliers and Missing Data
install.packages("plotly") # the plotly package can be used to make an interactive version of the plot where you can hover over interesting points to see more info
# this will make it easier to see where and what our outliers are
myPlot <- ggplot(diamonds, aes(carat, price)) +
  geom_point()

library(plotly)
ggplotly(myPlot)

# Labelling outliers
# Using the row number (the 5 carat diamond is on row 27,416)
ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  geom_text(
    aes(label = ifelse(rownames(diamonds) == 27416,
      rownames(diamonds), ""
    )),
    hjust = 1.1
  ) # hjust=1.1 shifts the text to the left of the point

# Plot text next to all diamonds with carat > 4
ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  geom_text(aes(label = ifelse(carat > 4, rownames(diamonds), "")),
    hjust = 1.1
  )

# Plot text next to 3 carat diamonds with a price below 7500
ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  geom_text(
    aes(label = ifelse(carat == 3 & price < 7500,
      rownames(diamonds), ""
    )),
    hjust = 1.1
  )
