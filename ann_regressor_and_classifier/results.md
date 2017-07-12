# Results

After training the regressor, we can score it with its R-squared  value (coefficient of determination)

Which get as <span style="font-size:20px"> `0.862340737187` </span>

> The definition of R-squared is fairly straight-forward; it is the percentage of the response variable variation that is explained by a linear model. Or:

> R-squared = Explained variation / Total variation

> R-squared is always between 0 and 100%:

> * 0% indicates that the model explains none of the variability of the response data around its mean.
> * 100% indicates that the model explains all the variability of the response data around its mean.

> In general, the higher the R-squared, the better the model fits your data.

> [source : http://blog.minitab.com/blog/adventures-in-statistics-2/regression-analysis-how-do-i-interpret-r-squared-and-assess-the-goodness-of-fit]

# Overfitting
* Overfitting might have been an issue if we did not have a good number of data points
* But since we are working with 7560 number of records overfitting should not be a problem 
