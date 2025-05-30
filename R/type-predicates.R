#' Sparse vector type checkers
#'
#' Helper functions to determine whether an vector is a sparse vector or not.
#'
#' @param x value to be checked.
#'
#' @details
#' `is_sparse_vector()` is a general function that detects any type of sparse
#' vector created with this package. `is_sparse_double()`,
#' `is_sparse_integer()`, `is_sparse_character()`, and `is_sparse_logical()` are
#' more specific functions that only detects the type. `is_sparse_numeric()`
#' matches both sparse integers and doubles.
#'
#' @return single logical value
#'
#' @examples
#' x_sparse <- sparse_double(c(pi, 5, 0.1), c(2, 5, 10), 10)
#' x_dense <- c(0, pi, 0, 0, 0.5, 0, 0, 0, 0, 0.1)
#'
#' is_sparse_vector(x_sparse)
#' is_sparse_vector(x_dense)
#'
#' is_sparse_double(x_sparse)
#' is_sparse_double(x_dense)
#'
#' is_sparse_character(x_sparse)
#' is_sparse_character(x_dense)
#'
#' # Forced materialization
#' is_sparse_vector(x_sparse[])
#' @name type-predicates
NULL

#' @rdname type-predicates
#' @export
is_sparse_vector <- function(x) {
  .Call(ffi_is_sparse_vector, x)
}

is_altrep_non_sparse_vector <- function(x) {
  .Call(ffi_is_altrep_non_sparse_vector, x)
}

#' @rdname type-predicates
#' @export
is_sparse_numeric <- function(x) {
  res <- .Call(ffi_extract_altrep_class, x)
  if (is.null(res)) {
    return(FALSE)
  }

  res <- as.character(res[[1]])

  res == "altrep_sparse_double" || res == "altrep_sparse_integer"
}

#' @rdname type-predicates
#' @export
is_sparse_double <- function(x) {
  res <- .Call(ffi_extract_altrep_class, x)
  if (is.null(res)) {
    return(FALSE)
  }

  res <- as.character(res[[1]])

  res == "altrep_sparse_double"
}

#' @rdname type-predicates
#' @export
is_sparse_integer <- function(x) {
  res <- .Call(ffi_extract_altrep_class, x)
  if (is.null(res)) {
    return(FALSE)
  }

  res <- as.character(res[[1]])

  res == "altrep_sparse_integer"
}

#' @rdname type-predicates
#' @export
is_sparse_character <- function(x) {
  res <- .Call(ffi_extract_altrep_class, x)
  if (is.null(res)) {
    return(FALSE)
  }

  res <- as.character(res[[1]])

  res == "altrep_sparse_string"
}

#' @rdname type-predicates
#' @export
is_sparse_logical <- function(x) {
  res <- .Call(ffi_extract_altrep_class, x)
  if (is.null(res)) {
    return(FALSE)
  }

  res <- as.character(res[[1]])

  res == "altrep_sparse_logical"
}
