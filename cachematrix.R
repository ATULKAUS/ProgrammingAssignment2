## makeCacheMatrix(): creates a special "matrix" object that can cache its inverse.
## This function's input is the argument x of type matrix. It has been assumed that
## the matrix is a square matrix and non-singular (i.e. has a non-zero determinant)
## and hence is invertible.
## This function's output is a list composed of four functions 
## 'set', 'get','setInv', 'getInv'.

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setInv <- function(solve) m <<- solve
  getInv <- function() m
  list(set = set, get = get,
       setInv = setInv,
       getInv = getInv)
}


## cacheSolve: This function computes the inverse of the special "matrix" 
## returned by makeCacheMatrix above. It checks the cache data first and 
## if the inverse has already been calculated (and the matrix has not changed), 
## then the cachesolve should retrieve the inverse from the cache. 
## Otherwise, if the matrix has changed, then it gets the new matrix and 
## computes the new inverse and sets the value of the inverse in the cache via 
## setInv() function.
## The input of this function is the matrix created using makeCacheMatrix()
## The output of this function is the inverse of the above matrix
## which has been either retrieved from the above function or computed
## depending on whether the matrix has changed or not.

cacheSolve <- function(x, ...) {
  m <- x$getInv()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data,...)
  x$setInv(m)
  m     
}