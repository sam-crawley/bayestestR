% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/point_estimate.R
\name{point_estimate}
\alias{point_estimate}
\alias{point_estimate.stanreg}
\alias{point_estimate.brmsfit}
\alias{point_estimate.BFBayesFactor}
\title{Point-estimates of posterior distributions}
\usage{
point_estimate(x, centrality = "median", dispersion = FALSE, ...)

\method{point_estimate}{stanreg}(x, centrality = "median",
  dispersion = FALSE, effects = c("fixed", "random", "all"),
  parameters = NULL, ...)

\method{point_estimate}{brmsfit}(x, centrality = "median",
  dispersion = FALSE, effects = c("fixed", "random", "all"),
  component = c("conditional", "zi", "zero_inflated", "all"),
  parameters = NULL, ...)

\method{point_estimate}{BFBayesFactor}(x, centrality = "median",
  dispersion = FALSE, ...)
}
\arguments{
\item{x}{Vector representing a posterior distribution. Can also be a
\code{stanreg}, \code{brmsfit} or a \code{BayesFactor} model.}

\item{centrality}{The point-estimates (centrality indices) to compute.  Character (vector) or list with one or more of these options: \code{"median"}, \code{"mean"}, \code{"MAP"} or \code{"all"}.}

\item{dispersion}{Logical, if \code{TRUE}, computes indices of dispersion related to the estimate(s) (\code{SD} and \code{MAD} for \code{mean} and \code{median}, respectively).}

\item{...}{Additional arguments to be passed to or from methods.}

\item{effects}{Should results for fixed effects, random effects or both be returned?
Only applies to mixed models. May be abbreviated.}

\item{parameters}{Regular expression pattern that describes the parameters that
should be returned. Meta-parameters (like \code{lp__} or \code{prior_}) are
filtered by default, so only parameters that typically appear in the
\code{summary()} are returned. Use \code{parameters} to select specific parameters
for the output.}

\item{component}{Should results for all parameters, parameters for the conditional model
or the zero-inflated part of the model be returned? May be abbreviated. Only
applies to \pkg{brms}-models.}
}
\description{
Compute various point-estimates, such as the mean, the median or the MAP, to describe posterior distributions.
}
\examples{
library(bayestestR)

point_estimate(rnorm(1000))
point_estimate(rnorm(1000), centrality = "all", dispersion = TRUE)
point_estimate(rnorm(1000), centrality = c("median", "MAP"))

df <- data.frame(replicate(4, rnorm(100)))
point_estimate(df, centrality = "all", dispersion = TRUE)
point_estimate(df, centrality = c("median", "MAP"))
\dontrun{
# rstanarm models
# -----------------------------------------------
library(rstanarm)
model <- rstanarm::stan_glm(mpg ~ wt + cyl, data = mtcars)
point_estimate(model, centrality = "all", dispersion = TRUE)
point_estimate(model, centrality = c("median", "MAP"))


# emmeans estimates
# -----------------------------------------------
library(emmeans)
point_estimate(emtrends(model, ~1, "wt"), centrality = c("median", "MAP"))

# brms models
# -----------------------------------------------
library(brms)
model <- brms::brm(mpg ~ wt + cyl, data = mtcars)
point_estimate(model, centrality = "all", dispersion = TRUE)
point_estimate(model, centrality = c("median", "MAP"))

# BayesFactor objects
# -----------------------------------------------
library(BayesFactor)
bf <- ttestBF(x = rnorm(100, 1, 1))
point_estimate(bf, centrality = "all", dispersion = TRUE)
point_estimate(bf, centrality = c("median", "MAP"))
}

}
\references{
\href{https://easystats.github.io/bayestestR/articles/indicesEstimationComparison.html}{Vignette In-Depth 1: Comparison of Point-Estimates}
}
