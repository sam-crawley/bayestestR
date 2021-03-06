% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/distribution.R
\name{distribution}
\alias{distribution}
\alias{distribution_normal}
\alias{distribution_binomial}
\alias{distribution_cauchy}
\alias{distribution_poisson}
\alias{distribution_student}
\alias{distribution_chisquared}
\alias{distribution_uniform}
\alias{distribution_beta}
\alias{distribution_gamma}
\alias{distribution_custom}
\alias{distribution_mixture_normal}
\alias{rnorm_perfect}
\title{Empirical Distributions}
\usage{
distribution(type = "normal", ...)

distribution_normal(n, mean = 0, sd = 1, random = FALSE, ...)

distribution_binomial(n, size = 1, prob = 0.5, random = FALSE, ...)

distribution_cauchy(n, location = 0, scale = 1, random = FALSE, ...)

distribution_poisson(n, lambda = 1, random = FALSE, ...)

distribution_student(n, df, ncp, random = FALSE, ...)

distribution_chisquared(n, df, ncp = 0, random = FALSE, ...)

distribution_uniform(n, min = 0, max = 1, random = FALSE, ...)

distribution_beta(n, shape1, shape2, ncp = 0, random = FALSE, ...)

distribution_gamma(n, shape, scale = 1, random = FALSE, ...)

distribution_custom(n, type = "norm", ..., random = FALSE)

distribution_mixture_normal(n, mean = c(-3, 3), sd = 1,
  random = FALSE, ...)

rnorm_perfect(n, mean = 0, sd = 1)
}
\arguments{
\item{type}{Can be \code{"normal"} (default), \code{"cauchy"}, \code{"poisson"}, \code{"gamma"}, \code{"chisquared"}, \code{"uniform"}, \code{"student"} or \code{"beta"}.}

\item{...}{Arguments passed to or from other methods.}

\item{n}{number of observations. If \code{length(n) > 1}, the length
    is taken to be the number required.}

\item{mean}{vector of means.}

\item{sd}{vector of standard deviations.}

\item{random}{Generate near-perfect or random (simple wrappers for the base R \code{r*} functions) distributions.}

\item{size}{number of trials (zero or more).}

\item{prob}{probability of success on each trial.}

\item{location}{location and scale parameters.}

\item{scale}{location and scale parameters.}

\item{lambda}{vector of (non-negative) means.}

\item{df}{degrees of freedom (\eqn{> 0}, maybe non-integer).  \code{df
      = Inf} is allowed.}

\item{ncp}{non-centrality parameter \eqn{\delta}{delta};
    currently except for \code{rt()}, only for \code{abs(ncp) <= 37.62}.
    If omitted, use the central t distribution.}

\item{min}{lower and upper limits of the distribution.  Must be finite.}

\item{max}{lower and upper limits of the distribution.  Must be finite.}

\item{shape1}{non-negative parameters of the Beta distribution.}

\item{shape2}{non-negative parameters of the Beta distribution.}

\item{shape}{shape and scale parameters.  Must be positive,
    \code{scale} strictly.}
}
\description{
Generate a sequence of n-quantiles, i.e., a sample of size \code{n} with a near-perfect distribution.
}
\examples{
library(bayestestR)
x <- distribution(n = 10)
plot(density(x))
}
