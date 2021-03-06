\name{dsyMatrix-class}
\title{Symmetric Dense (Packed | Non-packed) Numeric Matrices}
\docType{class}
\alias{dspMatrix-class}
\alias{dsyMatrix-class}
%
% \alias{solve, ..} --> solve-methods.Rd
% \alias{\%*%,  ..} --> matrix-products.Rd
\alias{coerce,dspMatrix,dsyMatrix-method}
\alias{coerce,dspMatrix,lspMatrix-method}
\alias{coerce,dspMatrix,matrix-method}
\alias{coerce,dspMatrix,CsparseMatrix-method}
\alias{coerce,dspMatrix,sparseMatrix-method}
\alias{coerce,dgeMatrix,dspMatrix-method}
\alias{coerce,matrix,dspMatrix-method}
\alias{coerce,dgeMatrix,dsyMatrix-method}% or rather setIs?
\alias{coerce,dsyMatrix,corMatrix-method}
\alias{coerce,dsyMatrix,dpoMatrix-method}% instead of setIs
\alias{coerce,dsyMatrix,dspMatrix-method}
\alias{coerce,dsyMatrix,lsyMatrix-method}
\alias{.dsy2mat}% hidden but exported
\alias{coerce,dsyMatrix,matrix-method}
\alias{coerce,matrix,dsyMatrix-method}
\alias{diag,dspMatrix-method}
\alias{diag,dsyMatrix-method}
\alias{diag<-,dspMatrix-method}
\alias{diag<-,dsyMatrix-method}
%
\alias{show,dsyMatrix-method}
\alias{norm,dspMatrix,character-method}
\alias{norm,dspMatrix,missing-method}
\alias{norm,dsyMatrix,character-method}
\alias{norm,dsyMatrix,missing-method}
\alias{rcond,dspMatrix,character-method}
\alias{rcond,dspMatrix,missing-method}
\alias{rcond,dsyMatrix,character-method}
\alias{rcond,dsyMatrix,missing-method}
\alias{t,dspMatrix-method}
\alias{t,dsyMatrix-method}
\description{
  \itemize{
    \item{The \code{"dsyMatrix"} class is the class of symmetric, dense matrices
      in \emph{non-packed} storage and}
    \item{\code{"dspMatrix"} is the class of symmetric dense matrices in
      \emph{packed} storage.  Only the upper triangle or the lower
      triangle is stored.}
  }
}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("dsyMatrix",
    ...)} or \code{new("dspMatrix", ...)}, respectively.
}
\section{Slots}{
  \describe{
    \item{\code{uplo}:}{Object of class \code{"character"}. Must be
      either "U", for upper triangular, and "L", for lower triangular.}
    \item{\code{x}:}{Object of class \code{"numeric"}. The numeric
      values that constitute the matrix, stored in column-major order.}
    \item{\code{Dim},\code{Dimnames}:}{The dimension (a length-2
      \code{"integer"}) and corresponding names (or \code{NULL}), see the
      \code{\linkS4class{Matrix}}.}
    \item{\code{factors}:}{Object of class \code{"list"}.  A named
      list of factorizations that have been computed for the matrix.}
  }
}
\section{Extends}{
  \code{"dsyMatrix"} extends class \code{"dgeMatrix"}, directly, whereas\cr
  \code{"dspMatrix"} extends class \code{"ddenseMatrix"}, directly.

  Both extend class \code{"symmetricMatrix"}, directly,
  and class \code{"Matrix"} and others, \emph{in}directly, use
  \code{\link{showClass}("dsyMatrix")}, e.g., for details.
}
\section{Methods}{
  \describe{
    \item{coerce}{\code{signature(from = "ddenseMatrix", to = "dgeMatrix")}}
    %
    \item{coerce}{\code{signature(from = "dspMatrix", to = "matrix")}}
    \item{coerce}{\code{signature(from = "dsyMatrix", to = "matrix")}}
    \item{coerce}{\code{signature(from = "dsyMatrix", to = "dspMatrix")}}
    \item{coerce}{\code{signature(from = "dspMatrix", to = "dsyMatrix")}}
    \item{norm}{\code{signature(x = "dspMatrix", type = "character")}, or
      \code{x = "dsyMatrix"} or \code{type = "missing"}: Computes the
      matrix norm of the desired type, see, \code{\link{norm}}.}
    \item{rcond}{\code{signature(x = "dspMatrix", type = "character")}, or
      \code{x = "dsyMatrix"} or \code{type = "missing"}: Computes the
      reciprocal condition number, \code{\link{rcond}()}.}
    \item{solve}{\code{signature(a = "dspMatrix", b = "....")}, and}
    \item{solve}{\code{signature(a = "dsyMatrix", b = "....")}: \code{x
	<- solve(a,b)} solves \eqn{A x = b} for \eqn{x}; see
      \code{\link{solve-methods}}.}
    \item{t}{\code{signature(x = "dsyMatrix")}: Transpose; swaps from
      upper triangular to lower triangular storage, i.e., the uplo slot
      from \code{"U"} to \code{"L"} or vice versa, the same as for all
      symmetric matrices.}
  }
}
%\references{}
\seealso{
  The \emph{positive (Semi-)definite} dense (packed or non-packed
  numeric matrix classes \code{\linkS4class{dpoMatrix}},
  \code{\linkS4class{dppMatrix}} and \code{\linkS4class{corMatrix}},

  Classes \code{\linkS4class{dgeMatrix}} and \code{\linkS4class{Matrix}};
  \code{\link[base]{solve}}, \code{\link{norm}}, \code{\link{rcond}},
  \code{\link[base]{t}}
}
\examples{
## Only upper triangular part matters (when uplo == "U" as per default)
(sy2 <- new("dsyMatrix", Dim = as.integer(c(2,2)), x = c(14, NA,32,77)))
str(t(sy2)) # uplo = "L", and the lower tri. (i.e. NA is replaced).

chol(sy2) #-> "Cholesky" matrix
(sp2 <- pack(sy2)) # a "dspMatrix"

## Coercing to dpoMatrix gives invalid object:
sy3 <- new("dsyMatrix", Dim = as.integer(c(2,2)), x = c(14, -1, 2, -7))
try(as(sy3, "dpoMatrix")) # -> error: not positive definite
\dontshow{
tr <- try(as(sy3, "dpoMatrix"), silent=TRUE)
stopifnot(1 == grep("not a positive definite matrix",
                    as.character(tr)),
	  is(sp2, "dspMatrix"))
}
}
\keyword{classes}
