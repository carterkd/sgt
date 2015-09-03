\name{sgtmle}
\alias{sgt.mle}
\alias{SGT.MLE}
\alias{print.MLE}
\alias{print.mult.MLE}

\title{Maximum Likelihood Estimation with the Skewed Generalized T Distribution}
\description{
  This function allows data to be fit to the skewed generalized t distribution using maximum likelihood estimation. This function uses the \code{maxLik} package to perform its estimations.
}
\usage{
sgt.mle(X.f, mu.f = mu ~ mu, sigma.f = sigma ~ sigma, 
lambda.f = lambda ~ lambda, p.f = p ~ p, q.f = q ~ q, 
data = parent.frame(), start, subset, 
method = c("Nelder-Mead", "BFGS"), itnmax = NULL,
hessian.method="Richardson", 
gradient.method="Richardson",
mean.cent = TRUE, var.adj = TRUE, \dots)
}
\arguments{
  \item{X.f}{A formula specifying the data, or the function of the data with parameters, that should be used in the maximisation procedure. \code{X} should be on the left-hand side and the right-hand side should be the data or function of the data that should be used.}
  \item{mu.f, sigma.f, lambda.f, p.f, q.f}{formulas including variables and
    parameters that specify the functional form of the parameters in the skewed generalized t log-likelihood function. \code{mu}, \code{sigma}, \code{lambda}, \code{p}, and \code{q} should be on the left-hand side of these formulas respectively.}
  \item{data}{an optional data frame in which to evaluate the variables in \code{formula} and \code{weights}.  Can also be a list or an environment.}
  \item{start}{a named list or named numeric vector of starting estimates for every parameter.}
  \item{subset}{an optional vector specifying a subset of observations to be used in the fitting process.}
  \item{method}{A list of the optimization methods to be used, which is passed directly to the \code{optimx} function in the \code{optimx} package. See \code{?optimx} for a list of methods that can be used.
   Note that the method that achieves the highest log-likelihood value is the method that is printed and reported.
   The default method is to use both "Nelder-Mead" and the "BFGS" methods.}
  \item{itnmax}{If provided as a vector of the same length as \code{method}, gives the maximum number of iterations or function values for the corresponding method. If a single number is provided, this will be used for all methods.}
  \item{hessian.method}{method used to calculate the hessian of the final estimates, either "Richardson" or "complex". This method is passed to the \code{hessian} function in the \code{numDeriv} package. See \code{?hessian} for details.}
  \item{gradient.method}{method used to calculate the gradient of the final estimates, either "Richardson", "simple", or "complex". This method is passed to the \code{grad} function in the \code{numDeriv} package. See \code{?grad} for details.}
  \item{mean.cent, var.adj}{arguments passed to the skewed generalized t distribution function (see \code{?dsgt}).}
  \item{\dots}{further arguments that are passed to the \code{control} argument in the \code{optimx} function in the \code{optimx} package. See \code{?optimx} for a list of arguments that can be used in the \code{control} argument.}
  }
\details{
  The parameter names are taken from \code{start}. If there is a name of a parameter or some data found on the right-hand side of one of the formulas but not found in \code{data} and not found in \code{start}, then an error is given.
  
  This function simply uses the \code{optimx} function in the \code{optimx} package to maximize the skewed generalized t distribution log-likelihood function. It takes the method that returned the highest log-likelihood, and saves these results as the final estimates.
}
\value{
  \code{sgt.mle} returns a list of class \code{"sgtest"}.
  A list of class \code{"sgtest"} has the following components:
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
}
\author{Carter Davis, \email{carterdavis@byu.edu}}
\references{
  Davis, Carter, James McDonald, and Daniel Walton (2015). 
  "A Generalized Regression Specification using the Skewed Generalized T Distribution" 
  working paper.
}

\seealso{The \code{optimx} package and its documentation. The \code{sgt.mle} simply uses its functions to maximize the skewed generalized t log-likelihood. Also, the \code{sgt.mle} function uses the \code{numDeriv} package to compute the final hessian and gradients of the estimates.
}
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

# REGRESSION MODEL ESTIMATION:
### Generate Random Data 
set.seed(1253)
n = 1000
x1 = rnorm(n)
x2 = runif(n)
y = 1 + 2*x1 + 3*x2 + rnorm(n)
data = as.data.frame(cbind(y, x1, x2))

### Estimate Linear Regression Model
reg = lm(y ~ x1 + x2, data = data)
coef = as.numeric(reg$coefficients)
rmse = summary(reg)$sigma
start = c(b0 = coef[1], b1 = coef[2], b2 = coef[3], 
g0 = log(rmse)+log(2)/2, g1 = 0, g2 = 0, d0 = 0, 
d1 = 0, d2 = 0, p = 2, q = 10)

### Set up Model
X.f = X ~ y - (b0 + b1*x1 + b2*x2)
mu.f = mu ~ 0
sigma.f = sigma ~ exp(g0 + g1*x1 + g2*x2)
lambda.f = lambda ~ (exp(d0 + d1*x1 + d2*x2)-1)/(exp(d0 + d1*x1 + d2*x2)+1)

### Estimate Regression with a skewed generalized t error term
### This estimates the regression model from the Davis, 
### McDonald, and Walton (2015) paper cited in the references section
### q is in reality infinite since the error term is normal
result = sgt.mle(X.f = X.f, mu.f = mu.f, sigma.f = sigma.f, 
lambda.f = lambda.f, data = data, start = start, 
var.adj = FALSE, method = "nlm")
print(result)
print(summary(result))
}
\keyword{optimize}
