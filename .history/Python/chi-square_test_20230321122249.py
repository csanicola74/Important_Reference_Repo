import matplotlib.pyplot as plt
import numpy as np
from scipy import stats

Compare Dependency of Categorical Variables with Chi-Square Test(Stat-12)
Complete Guideline to Find Dependencies among Categorical Variables with Chi-Square Test

Photo by Kier In Sight on Unsplash
Motivation
Many statistical tests are available, like the p-test, z-test, students’ t-test, ANOVA test, etc. Why do we need the Chi-Square test? None of the above tests show the dependency of categorical variables. Chi-Square test is the best statistical weapon for doing the job. The main idea behind the test is the following clause[2]—

“Goodness of fit.”

Let’s make it a little bit easier with an example. Suppose you toss a coin 18 times. Generally, the probability of the outcome of head and tail is o.5. So, the probability says if you toss a coin 18 times, you should get 9 times head and 9 times tail. But you observed the occurrence of the head is 12 times instead of 9 times. That means there is a difference between the expected and the observed value. Chi-Square test shows how close our observed and expected value is !

Chi-Square Test(X²)
The Chi-Square test is a test that identifies whether there are any significant differences between the observed number of occurrences of an event and the expected number of occurrences or not . According to Wikipedia —

Pearson’s chi-squared test is used to determine whether there is a statistically significant difference between the expected and observed frequencies in one or more categories of a contingency table[1].

In 1900, Karl Pearson wrote a paper[2] on the Chi-Square test —

On the criterion that a given system of deviations from the probable in the case of a correlated system of variables is such that it can be reasonably supposed to have arisen from random sampling

The title is a little bit longer and hard to realize. So, he also expressed the objective of the test by saying —

“The object of this paper is to investigate a criterion of the probability on any theory of an observed system of errors, and apply it to the determination of goodness of fit in the case of frequency curves.”

Karl Pearson never used the name Chi-Square in the test, and he just used the symbol X² to represent the test. After that, according to the name of the Greek letter X, people call the test Chi-Square.

The formula for calculating the Chi-Square(X²) is simple.


Where, O is the observed value, and the E is the expected value.

Chi-Square distribution
There is a standard value for Chi-Square distribution. With the standard value, we decide whether we accept or reject our hypothesis. The tutorial[3] helps me to implement the distribution with ease. Let’s try to plot the distribution with some lines of Python code.


x = np.linspace(0, 10, 100)
# f=fig.figure(figsize=(2, 2))

fig, ax = plt.subplots(1, 1, figsize=(15, 10))

plt.axhline(y=0.05, xmin=0, xmax=10, color='black')


deg_of_freedom = [1, 2, 3, 4, 7, 6, 8]
for df in deg_of_freedom:
    ax.plot(x, stats.chi2.pdf(x, df), label='df = ' + str(df))


ax.set_xlabel('Value', fontsize=12, fontweight='bold')
ax.set_ylabel('Probability Distribution', fontsize=12, fontweight='bold')
ax.set_title('Chi-Square Distribution', fontsize=16, fontweight='bold')

plt.xlim(0, 10)
plt.ylim(0, 0.6)


plt.legend()
plt.show()
