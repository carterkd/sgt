\name{sgt}
\alias{SGT}
\alias{sgt}
\alias{dsgt}
\alias{psgt}
\alias{qsgt}
\alias{rsgt}

\title{The Skewed Generalized T Distribution}
\description{
  Density, distribution function, quantile function and random
  generation for the skewed generalized t distribution.
}
\usage{
dsgt(x, mu = 0, sigma = 1, lambda = 0, p = 2, q = Inf, 
mean.cent = TRUE, var.adj = TRUE, log = FALSE)
psgt(quant, mu = 0, sigma = 1, lambda = 0, p = 2, q = Inf, 
mean.cent = TRUE, var.adj = TRUE, lower.tail = TRUE, 
log.p = FALSE)
qsgt(prob, mu = 0, sigma = 1, lambda = 0, p = 2, q = Inf, 
mean.cent = TRUE, var.adj = TRUE, lower.tail = TRUE, 
log.p = FALSE)
rsgt(n, mu = 0, sigma = 1, lambda = 0, p = 2, q = Inf, 
mean.cent = TRUE, var.adj = TRUE)
}
\arguments{
  \item{x, quant}{vector of quantiles.}
  \item{prob}{vector of probabilities.}
  \item{n}{number of observations. If \code{length(n) > 1}, the length
    is taken to be the number required.}
  \item{mu}{vector of parameters. Note that if \code{mean.cent == TRUE}, \code{mu} is the mean of the distribution. Otherwise, \code{mu} is the mode of the distribution.}
  \item{sigma}{vector of variance parameters. The default is 1. The variance of the distribution increases as \code{sigma} increases. Must be strictly positive.}
  \item{lambda}{vector of skewness parameters. Note that \code{-1 < lambda < 1}. If \code{lambda < 0}, the distribution is skewed to the left. If \code{lambda > 0}, the distribution is skewed to the right. If \code{lambda = 0}, then the distribution is symmetric.}
  \item{p, q}{vector of parameters. Smaller values of \code{p} and \code{q} result in larger values for the kurtosis of the distribution. Allowed to be infinite. Note that \code{p > 0}, \code{q > 0}, otherwise \code{NaNs} will be produced.}
  \item{mean.cent}{logical; if TRUE, \code{mu} is the mean of the distribution, otherwise \code{mu} is the mode of the distribution. May only be used if \code{p*q > 1}, otherwise \code{NaNs} will be produced.}
  \item{var.adj}{logical or a positive scalar. If \code{TRUE}, then \code{sigma} is rescaled so that \code{sigma} is the variance. If \code{FALSE}, then \code{sigma} is not rescaled. If \code{var.adj} is a positive scalar, then \code{sigma} is rescaled by \code{var.adj}. May only be used if \code{p*q > 2}, otherwise \code{NaNs} will be produced.}
  \item{log, log.p}{logical; if TRUE, probabilities p are given as log(p).}
  \item{lower.tail}{logical; if TRUE (default), probabilities are
    \eqn{P[X \le x]} otherwise, \eqn{P[X > x]}.}
}
\value{
  \code{dsgt} gives the density,
  \code{psgt} gives the distribution function,
  \code{qsgt} gives the quantile function, and
  \code{rsgt} generates random deviates.
  
  The length of the result is determined by \code{n} for
  \code{rsgt}, and is the maximum of the lengths of the
  numerical arguments for the other functions.  
  
  The numerical arguments other than \code{n} are recycled to the
  length of the result.  Only the first elements of the logical
  arguments are used.
  
  \code{sigma <= 0}, \code{lambda <= -1}, \code{lambda >= 1}, \code{p <= 0}, and \code{q <= 0} are errors and return \code{NaN}. Also, if \code{mean.cent} is \code{TRUE} but code{p*q <= 1}, the result is an error and \code{NaNs} are produced. Similarly, if \code{var.adj} is \code{TRUE} but code{p*q <= 2}, the result is an error and \code{NaNs} are produced.
}
\author{Carter Davis, \email{carterdavis@byu.edu}}
\details{
  If \code{mu}, \code{sigma}, \code{lambda}, \code{p}, or \code{q} are not specified they assume the default values of \code{mu = 0}, \code{sigma = 1}, \code{lambda = 0}, \code{p = 2}, and \code{q = Inf}. These default values yield a standard normal distribution. 

  See \code{vignette('sgt')} for the probability density function, moments, and various special cases of the skewed generalized t distribution.
}
\seealso{
  \link{Distributions} for other standard distributions which are special cases of the skewed generalized t distribution, including \code{\link{dt}} for the t distribution, \code{\link{dnorm}} for the normal distribution, and \code{\link{dunif}} for the uniform distribution. Other special cases of the skewed generalized t distribution include the generalized t distribution in the \code{gamlss.dist} package, the skewed t distribution in the \code{skewt} package, the exponential power distribution (also known as the generalized error distribution) in the \code{normalp} package, and the Laplace distribution in the \code{rmutil} package. Also see \code{\link{beta}} for the beta function.
}
\source{
  For \code{psgt}, based on
  
  a transformation of the cumulative probability density function that uses the incomplete beta function or incomplete gamma function.

  For \code{qsgt}, based on
  
  solving for the inverse of the \code{psgt} function that uses the inverse of the incomplete beta function or incomplete gamma function.

  For \code{rsgt}, the algorithm simply uses the \code{qsgt} function with probabilities that are uniformly distributed.
}
\references{
  
  Hansen, C., McDonald, J. B., and Newey, W. K. (2010)
  "Instrumental Variables Regression with Flexible Distributions"
  \emph{Journal of Business and Economic Statistics}, volume 28, 13-25.
  
  Kerman, S. C., and McDonald, J. B. (2012)
  "Skewness-Kurtosis Bounds for the Skewed Generalized T and Related Distributions"
  \emph{Statistics and Probability Letters}, volume 83, 2129-2134.
	
  Theodossiou, Panayiotis (1998)
  "Financial Data and the Skewed Generalized T Distribution"
  \emph{Management Science}, volume 44, 1650-1661.
  
}
\examples{
require(graphics)

### This shows how to get a normal distribution
x = seq(-4,6,by=0.05)
plot(x, dnorm(x, mean=1, sd=1.5), type='l')
lines(x, dsgt(x, mu=1, sigma=1.5), col='blue')

### This shows how to get a cauchy distribution
plot(x, dcauchy(x, location=1, scale=1.3), type='l')
lines(x, dsgt(x, mu=1, sigma=1.3, q=1/2, mean.cent=FALSE, var.adj = sqrt(2)), col='blue')

### This shows how to get a Laplace distribution
plot(x, dsgt(x, mu=1.2, sigma=1.8, p=1, var.adj=FALSE), type='l', col='blue')

### This shows how to get a uniform distribution
plot(x, dunif(x, min=1.2, max=2.6), type='l')
lines(x, dsgt(x, mu=1.9, sigma=0.7, p=Inf, var.adj=FALSE), col='blue')

}
\keyword{distribution}
