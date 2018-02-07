### Introduction

This second programming assignment will require you to write an R function that is able to cache potentially time-consuming computations. For example, taking the mean of a numeric vector is typically a fast operation. However, for a very long vector, it may take too long to compute the mean, especially if it has to be computed repeatedly (e.g. in a loop). If the contents of a vector are not changing, it may make sense to cache the value of the mean so that when we need it again, it can be looked up in the cache rather than recomputed. In this Programming Assignment you will take advantage of the scoping rules of the R language and how they can be manipulated to preserve state inside of an R object.

### Example: Caching the Mean of a Vector

In this example we introduce the `<<-` operator which can be used to assign a value to an object in an environment that is different from the current environment. Below are two functions that are used to create a special object that stores a numeric vector and caches its mean. 

The first function, `makeVector` creates a special "vector", which is really a list containing a function to

1.  set the value of the vector
2.  get the value of the vector
3.  set the value of the mean
4.  get the value of the mean

<!-- -->

    makeVector <- function(x = numeric()) {
            m <- NULL
            set <- function(y) {
                    x <<- y
                    m <<- NULL
            }
            get <- function() x
            setmean <- function(mean) m <<- mean
            getmean <- function() m
            list(set = set, get = get,
                 setmean = setmean,
                 getmean = getmean)
    }

The following function calculates the mean of the special "vector" created with the above function. However, it first checks to see if the mean has already been calculated. If so, it `get`s the mean from the cache and skips the computation. Otherwise, it calculates the mean of the data and sets the value of the mean in the cache via the `setmean` function.

    cachemean <- function(x, ...) {
            m <- x$getmean()
            if(!is.null(m)) {
                    message("getting cached data")
                    return(m)
            }
            data <- x$get()
            m <- mean(data, ...)
            x$setmean(m)
            m
    }

### Assignment: Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some benefit to caching the inverse of a matrix rather than computing it repeatedly (there are also alternatives to matrix inversion that we will not discuss here). Your assignment is to write a pair of functions that cache the inverse of a matrix.

Write the following functions:

1.  `makeCacheMatrix`: This function creates a special "matrix" object that can cache its inverse.
2.  `cacheSolve`: This function computes the inverse of the special "matrix" returned by `makeCacheMatrix` above. If the inverse has already been calculated (and the matrix has not changed), then `cacheSolve` should retrieve the inverse from the cache.

Computing the inverse of a square matrix can be done with the `solve` function in R. For example, if `X` is a square invertible matrix, then `solve(X)` returns its inverse.

For this assignment, assume that the matrix supplied is always invertible.

In order to complete this assignment, you must do the following:

1.  Fork the GitHub repository containing the stub R files at [https://github.com/rdpeng/ProgrammingAssignment2](https://github.com/rdpeng/ProgrammingAssignment2) to create a copy under your own account.
2.  Clone your forked GitHub repository to your computer so that you can edit the files locally on your own machine.
3.  Edit the R file contained in the git repository and place your solution in that file (please do not rename the file).
4.  Commit your completed R file into YOUR git repository and push your git branch to the GitHub repository under your account.
5.  Submit to Coursera the URL to your GitHub repository that contains the completed R code for the assignment.

### Grading

This assignment will be graded via peer assessment.


## How to use the matrix caching function created as part of this assignment

## Clean the environment from data from previous runs 

```r
rm(list = ls())
```




#### Import the functions

```r
source("cachematrix.R")
```


Set seed to get the same results from the random function. 

```r
set.seed(1000)
```



Create a random 10 x 10 matrix.

```r
x <- matrix(rnorm(100), 10, 10)
```



Call makecache function with the matrix x

```r
inverseMatrixCacheFunction <- makeCacheMatrix(x)
```



Check if the value of the matrix passed is returned by the get function. 

```r
inverseMatrixCacheFunction$get()
```

```
##           [,1]     [,2]    [,3]    [,4]     [,5]    [,6]     [,7]    [,8]     [,9]   [,10]
##  [1,] -0.44578 -0.98243  2.6701 -0.2115 -0.51731  0.2517  0.54393 -1.4983  1.16928  1.9715
##  [2,] -1.20586 -0.55449 -1.2270  0.6994  1.41174 -1.0947 -0.39234  0.6610  0.24797 -1.9210
##  [3,]  0.04113  0.12138  0.8342 -0.7064  0.18547  0.3976  1.23544  0.2855 -0.35815  0.4621
##  [4,]  0.63939 -0.12087  0.5326 -0.4652 -0.04369 -0.9963  1.19609  1.3889  1.38349 -0.1607
##  [5,] -0.78655 -1.33604 -0.6468 -1.7662 -0.21591  0.1006 -0.49575 -0.1593  0.41207 -0.1042
##  [6,] -0.38549  0.17006  0.6032  0.1893  1.46378  0.9537 -0.29434 -0.4609 -0.12301  0.4678
##  [7,] -0.47587  0.15508 -1.7838 -0.3662  0.22967 -1.7903 -0.57350  0.1684 -0.06623  0.4439
##  [8,]  0.71975  0.02493  0.3349  1.0576  0.10762  0.3117  1.61921  1.3955 -2.32249  0.8286
##  [9,] -0.01851 -2.04659  0.5610 -0.7416 -1.37810  2.5540 -0.95693  0.7284 -1.04566 -0.3871
## [10,] -1.37312  0.21315  1.2209 -1.3484 -0.96818 -0.8608  0.04124  0.3351  2.05788  2.0189
```


Get back the stored inverse value for this matrix x. The value should be NULL as it is not calculated yet. 


```r
inverseMatrixCacheFunction$getInverse()
```

```
## NULL
```




Call the cacheSolve function with the Cache function. This should calculate the inverse for the first time. 

```r
inverseMatrixCacheSolveFunction <- cacheSolve(inverseMatrixCacheFunction)
```


Print the value of the inverse calculated. 


```r
inverseMatrixCacheSolveFunction
```

```
##           [,1]     [,2]    [,3]     [,4]    [,5]     [,6]    [,7]     [,8]     [,9]   [,10]
##  [1,]  0.16824 -0.30229  0.2715  0.50522 -0.5121  0.17724  0.6930 -0.37918  0.33497 -0.4739
##  [2,] -0.22963 -0.03192  0.6580 -0.19127 -0.6062 -0.05050  0.1863 -0.36692  0.09598  0.1365
##  [3,]  0.61239  0.43214  2.3693  0.19412 -2.3140 -0.09618  1.8953 -1.32574  1.30295 -0.4337
##  [4,] -0.13793 -0.03203 -1.6022 -0.12838  0.9059  0.01215 -1.1461  0.83826 -0.64958  0.2881
##  [5,]  0.09495  0.05808  0.3313  0.26241 -0.2315  0.52573  0.4564 -0.18568  0.14683 -0.2222
##  [6,] -0.55650 -0.35131 -1.7536 -0.18812  1.6991  0.26863 -1.7883  0.97425 -0.89497  0.4428
##  [7,] -0.33658 -0.16588 -1.4040 -0.21525  1.8507 -0.20630 -1.7873  1.11286 -1.17694  0.3291
##  [8,] -0.14209  0.08709  0.1291  0.27840 -0.3920  0.18707  0.2914 -0.01785  0.34585  0.1602
##  [9,] -0.35801 -0.27465 -1.8167  0.13703  1.4871  0.19420 -1.4965  0.76468 -0.88751  0.3919
## [10,] -0.12017 -0.33801 -1.1175  0.02482  0.8451  0.33403 -0.4901  0.66958 -0.44401  0.2629
```



Call the function again should return the cached value.


```r
inverseMatrixCacheSolveFunction <- cacheSolve(inverseMatrixCacheFunction)
```

```
## getting cached data
```

```r
inverseMatrixCacheSolveFunction
```

```
##           [,1]     [,2]    [,3]     [,4]    [,5]     [,6]    [,7]     [,8]     [,9]   [,10]
##  [1,]  0.16824 -0.30229  0.2715  0.50522 -0.5121  0.17724  0.6930 -0.37918  0.33497 -0.4739
##  [2,] -0.22963 -0.03192  0.6580 -0.19127 -0.6062 -0.05050  0.1863 -0.36692  0.09598  0.1365
##  [3,]  0.61239  0.43214  2.3693  0.19412 -2.3140 -0.09618  1.8953 -1.32574  1.30295 -0.4337
##  [4,] -0.13793 -0.03203 -1.6022 -0.12838  0.9059  0.01215 -1.1461  0.83826 -0.64958  0.2881
##  [5,]  0.09495  0.05808  0.3313  0.26241 -0.2315  0.52573  0.4564 -0.18568  0.14683 -0.2222
##  [6,] -0.55650 -0.35131 -1.7536 -0.18812  1.6991  0.26863 -1.7883  0.97425 -0.89497  0.4428
##  [7,] -0.33658 -0.16588 -1.4040 -0.21525  1.8507 -0.20630 -1.7873  1.11286 -1.17694  0.3291
##  [8,] -0.14209  0.08709  0.1291  0.27840 -0.3920  0.18707  0.2914 -0.01785  0.34585  0.1602
##  [9,] -0.35801 -0.27465 -1.8167  0.13703  1.4871  0.19420 -1.4965  0.76468 -0.88751  0.3919
## [10,] -0.12017 -0.33801 -1.1175  0.02482  0.8451  0.33403 -0.4901  0.66958 -0.44401  0.2629
```

