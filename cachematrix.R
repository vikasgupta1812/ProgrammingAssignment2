## Put comments here that give an overall description of what your
## functions do

## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  
  # Initialize the inverseOfx variable with NULL value. The function will return this value when the inverse is not calculated once. 
  inverseOfx  <- NULL
  
  # set function takes the value y and sets it as a value for x in other environment
  # It does not calculates the value of inverse. 
  set  <- function(y){
    x  <<- y
    inverseOfx  <<- NULL 
  }
  # get is a function which returns the value of input matrix x
  get  <- function() x
  # Whenever cacheSolve function computes the inverse, it passes the value of inverse back to this function and this values is cached. 
  setInverse  <- function(solve) inverseOfx  <<- solve
  
  # This function returns back the value of inverse of a matrix. If the value is not calculated even once by the cacheSolve, NULL value will be returned. Otherwise a cached value will be returned. 
  getInverse  <- function() inverseOfx
  # This is the list of all 4 funcitons defined in the makeCacheMatrix function. These functions can be called form outside to perform different operations, like passing the initial value of matrix, obtaining the value of stored matrix, storing the value of inverse and retreiving the value of cached inverse. 
  list(  
    set = set,                  # Pass the matrix
    get = get,                  # Get back the matrix 
    setInverse = setInverse,    # Save the value of inverse of matrix 
    getInverse = getInverse     # Get back the value of inverse of matrix
    )
}

## This function computes the inverse of the special "matrix" returned by `makeCacheMatrix` above. If the inverse has already been calculated (and the matrix has not changed), then `cacheSolve` should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  # Obtain the cached value. 
  inverseOfx  <- x$getInverse()

  if(!is.null(inverseOfx)) {              # If a cache is found
    message("getting cached data")        # print the message to console 
    return(inverseOfx)                    # return the cache  
  }
  # If cached value is not found 
  inverseOfx  <- solve(x$get(), ...)      # then compute the inverse of a matrix. 
  x$setInverse(inverseOfx)                # Save the result back to cached Matrix
  inverseOfx                              # Return the result.
}
