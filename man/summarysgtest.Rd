\name{summary.sgtest}
\alias{summary.sgtest}
\alias{coef.summary.sgtest}
\title{Summary the Maximum-Likelihood Estimation with the Skewed Generalized T Distribution}
\description{
  Summary the maximum-likelihood estimation.
}
\usage{
\method{summary}{sgtest}(object, \dots)
}

\arguments{
  \item{object}{
    object of class \code{'sgtest'}, usually a result from
    maximum-likelihood estimation.
  }
  \item{\dots}{currently not used.}
}
\value{
  \code{summary.sgtest} returns an
  object of class \code{'summary.sgtest'} with the following components:
  \item{maximum}{log-likelihood value of estimates (the last calculated value
    if not converged) of the method that achieved the greatest log-likelihood value.}
  \item{estimate}{estimated parameter value with the method that achieved the greatest log-likelihood value.}
  \item{convcode}{\code{convcode} returned from the \code{optimx} function in the \code{optimx} package of the method that achieved the greatest log-likelihood value. See \code{?optimx} for the different \code{convcode} values.}
  \item{niter}{The amount of iterations that the method which achieved the the greatest log-likelihood value used to reach its estimate.}
  \item{best.method.used}{name of the method that achieved the greatest log-likelihood value.}
  \item{optimx}{A \code{data.frame} of class \code{"optimx"} that contains the results of the \code{optimx} maximization for every method (\emph{not} just the method that achieved the highest log-likelihood value). See \code{?optimx} for details.}
  \item{gradient}{vector, gradient value of the estimates with the method that achieved the greatest log-likelihood value.}
  \item{hessian}{matrix, hessian of the estimates with the method that achieved the greatest log-likelihood value.}
  \item{varcov}{variance/covariance matrix of the maximimum likelihood estimates}
  \item{std.error}{standard errors of the estimates}
  \item{z.score}{the z score of the estimates}
  \item{p.value}{the p-values of the estimates}
  \item{summary.table}{a \code{data.frame} containing the estimates, standard errors, z scores, and p-values of the estimates.}
}
\author{Carter Davis, \email{cdavis40@chicagobooth.edu}}
\seealso{the \code{optimx} CRAN package}
\examples{
# SINGLE VARIABLE ESTIMATION:
### generate random variable
set.seed(7900)
n = 1000
x = rsgt(n, mu = 2, sigma = 2, lambda = -0.25, p = 1.7, q = 7)

### Get starting values and estimate the parameter values
start = list(mu = 0, sigma = 1, lambda = 0, p = 2, q = 10)
result = sgt.mle(X.f = ~ x, start = start, method = "nlminb")
print(result)
print(summary(result))
}
\keyword{models}
