## Put comments here that give an overall description of what your
## functions do

## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  
  inverseOfx  <- NULL
  set  <- function(y){
    x  <<- y
    inverseOfx  <<- NULL 
  }
  get  <- function() x
  # Identify the inverse of a matrix by using function solve()
  setInverse  <- function(solve) inverseOfx  <<- solve
  
  getInverse  <- function() inverseOfx
  list(
    set = set,
    get = get,
    setInverse = setInverse,
    getInverse = getInverse
    )
}

## This function computes the inverse of the special "matrix" returned by `makeCacheMatrix` above. If the inverse has already been calculated (and the matrix has not changed), then `cacheSolve` should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  # Obtain the cached value. 
  inverseOfx  <- x$getInverse()
  # If cache is found, then return the cached value and skip the calculation
  if(!is.null(inverseOfx)) {
    message("getting cached data")
    return(inverseOfx)
  }
  # If cached value is not found then compute the inverse of a matrix. 
  data  <- x$get()
  inverseOfx  <- solve(x, ...)
  x$setInverse()
  inverseOfx    
}
