# Clustering anime

If you read the previous article you might have realized why finding the nearest neighbours is necessary in many clustering algorithms.

Among all the ways available to measure the closeness between two data points we'll use the euclidean distance.

I wrote in PLSQL a simple script to do clustering using `k-means++` algorithm. It is very much alike the LLoyd's algorithm for k-means but with some optimization in the beginning.

The optimization is how we choose the initial k points acting as means. The steps go
1. Choose one center at random from the data points.
1. For each data point x, compute *D(x)*, the distance between x and the nearest center that has already been chosen.
1. Choose one new data point at random as a new center, using a weighted probability distribution where a point x is chosen with probability proportional to *D(x)<sup>2</sup>*
1. Repeat Steps 2 and 3 until k centers have been chosen.
