% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bayesfactor_parameters.R
\name{bayesfactor_parameters}
\alias{bayesfactor_parameters}
\alias{bayesfactor_savagedickey}
\alias{bayesfactor_parameters.numeric}
\alias{bayesfactor_parameters.stanreg}
\alias{bayesfactor_parameters.brmsfit}
\alias{bayesfactor_parameters.emmGrid}
\alias{bayesfactor_parameters.data.frame}
\title{Savage-Dickey density ratio Bayes Factor (BF)}
\usage{
bayesfactor_parameters(posterior, prior = NULL,
  direction = "two-sided", null = 0, verbose = TRUE, ...)

bayesfactor_savagedickey(posterior, prior = NULL,
  direction = "two-sided", null = 0, verbose = TRUE,
  hypothesis = NULL, ...)

\method{bayesfactor_parameters}{numeric}(posterior, prior = NULL,
  direction = "two-sided", null = 0, verbose = TRUE, ...)

\method{bayesfactor_parameters}{stanreg}(posterior, prior = NULL,
  direction = "two-sided", null = 0, verbose = TRUE,
  effects = c("fixed", "random", "all"), component = c("conditional",
  "zi", "zero_inflated", "all"), ...)

\method{bayesfactor_parameters}{brmsfit}(posterior, prior = NULL,
  direction = "two-sided", null = 0, verbose = TRUE,
  effects = c("fixed", "random", "all"), component = c("conditional",
  "zi", "zero_inflated", "all"), ...)

\method{bayesfactor_parameters}{emmGrid}(posterior, prior = NULL,
  direction = "two-sided", null = 0, verbose = TRUE, ...)

\method{bayesfactor_parameters}{data.frame}(posterior, prior = NULL,
  direction = "two-sided", null = 0, verbose = TRUE, ...)
}
\arguments{
\item{posterior}{A numerical vector, \code{stanreg} / \code{brmsfit} object, \code{emmGrid}
or a data frame - representing a posterior distribution(s) from (see Details).}

\item{prior}{An object representing a prior distribution (see Details).}

\item{direction}{Test type (see details). One of \code{0}, \code{"two-sided"} (default, two tailed),
\code{-1}, \code{"left"} (left tailed) or \code{1}, \code{"right"} (right tailed).}

\item{null}{Value of the null, either a scaler (for point-null) or a a range
(for a interval-null).}

\item{verbose}{Toggle off warnings.}

\item{...}{Currently not used.}

\item{hypothesis}{Deprecated in favour of \code{null}.}

\item{effects}{Should results for fixed effects, random effects or both be returned?
Only applies to mixed models. May be abbreviated.}

\item{component}{Should results for all parameters, parameters for the conditional model
or the zero-inflated part of the model be returned? May be abbreviated. Only
applies to \pkg{brms}-models.}
}
\value{
A data frame containing the Bayes factor representing evidence \emph{against} the null.
}
\description{
This method computes Bayes factors against the null (either a point or an interval),
bases on prior and posterior samples of a single parameter. This Bayes factor indicates
the degree by which the mass of the posterior distribution has shifted further away
from or closer to the null value(s) (relative to the prior distribution), thus indicating
if the null value has become less or more likely given the observed data.
\cr \cr
When the null is an interval, the Bayes factor is computed by comparing the prior
and posterior odds of the parameter falling within or outside the null;
When the null is a point, a Savage-Dickey density ratio is computed, which is also
an approximation of a Bayes factor comparing the marginal likelihoods of the model
against a model in which the tested parameter has been restricted to the point null.
\cr \cr
\strong{For info on specifying correct priors for factors with more than 2 levels, see \href{https://easystats.github.io/bayestestR/articles/bayes_factors.html}{the Bayes factors vignette}.}
\cr \cr
For more info, see \href{https://easystats.github.io/bayestestR/articles/bayes_factors.html}{the Bayes factors vignette}.
}
\details{
This method is used to compute Bayes factors based on prior and posterior distributions.
When \code{posterior} is a model (\code{stanreg}, \code{brmsfit}), posterior and prior samples are
extracted for each parameter, and Savage-Dickey Bayes factors are computed for each parameter.

\strong{NOTE:} For \code{brmsfit} models, the model must have been fitted with \emph{custom (non-default)}
priors. See example below.

\subsection{Setting the correct \code{prior}}{
It is important to provide the correct \code{prior} for meaningful results.
\itemize{
  \item When \code{posterior} is a numerical vector, \code{prior} should also be a numerical vector.
  \item When \code{posterior} is a \code{data.frame}, \code{prior} should also be a \code{data.frame}, with matching column order.
  \item When \code{posterior} is a \code{stanreg} or \code{brmsfit} model: \itemize{
    \item \code{prior} can be set to \code{NULL}, in which case prior samples are drawn internally.
    \item \code{prior} can also be a model equvilant to \code{posterior} but with samples from the priors \emph{only}.
  }
  \item When \code{posterior} is an \code{emmGrid} object: \itemize{
    \item \code{prior} should be the \code{stanreg} or \code{brmsfit} model used to create the \code{emmGrid} objects.
    \item \code{prior} can also be an \code{emmGrid} object equvilant to \code{posterior} but created with a model of priors samples \emph{only}.
  }
}}
\subsection{One-sided Tests (setting an order restriction)}{
One sided tests (controlled by \code{direction}) are conducted by restricting the prior and
posterior of the non-null values (the "alternative") to one side of the null only
(\cite{Morey & Wagenmakers, 2013}). For example, if we have a prior hypothesis that the
parameter should be positive, the alternative will be restricted to the region to the right
of the null (point or interval).
}
\subsection{Interpreting Bayes Factors}{
A Bayes factor greater than 1 can be interpereted as evidence against the null,
at which one convention is that a Bayes factor greater than 3 can be considered
as "substantial" evidence against the null (and vice versa, a Bayes factor
smaller than 1/3 indicates substantial evidence in favor of the null-model)
(\cite{Wetzels et al. 2011}).
}
}
\examples{
library(bayestestR)

prior <- distribution_normal(1000, mean = 0, sd = 1)
posterior <- distribution_normal(1000, mean = .5, sd = .3)

bayesfactor_parameters(posterior, prior)
\dontrun{
# rstanarm models
# ---------------
library(rstanarm)
contrasts(sleep$group) <- contr.bayes # see vingette
stan_model <- stan_lmer(extra ~ group + (1 | ID), data = sleep)
bayesfactor_parameters(stan_model)
bayesfactor_parameters(stan_model, null = rope_range(stan_model))

# emmGrid objects
# ---------------
library(emmeans)
group_diff <- pairs(emmeans(stan_model, ~group))
bayesfactor_parameters(group_diff, prior = stan_model)

# brms models
# -----------
library(brms)
contrasts(sleep$group) <- contr.bayes # see vingette
my_custom_priors <-
  set_prior("student_t(3, 0, 1)", class = "b") +
  set_prior("student_t(3, 0, 1)", class = "sd", group = "ID")

brms_model <- brm(extra ~ group + (1 | ID),
  data = sleep,
  prior = my_custom_priors
)
bayesfactor_parameters(brms_model)
}

}
\references{
\itemize{
\item Wagenmakers, E. J., Lodewyckx, T., Kuriyal, H., and Grasman, R. (2010). Bayesian hypothesis testing for psychologists: A tutorial on the Savage-Dickey method. Cognitive psychology, 60(3), 158-189.
\item Wetzels, R., Matzke, D., Lee, M. D., Rouder, J. N., Iverson, G. J., and Wagenmakers, E.-J. (2011). Statistical Evidence in Experimental Psychology: An Empirical Comparison Using 855 t Tests. Perspectives on Psychological Science, 6(3), 291–298. \doi{10.1177/1745691611406923}
\item Heck, D. W. (2019). A caveat on the Savage–Dickey density ratio: The case of computing Bayes factors for regression parameters. British Journal of Mathematical and Statistical Psychology, 72(2), 316-333.
\item Morey, R. D., & Wagenmakers, E. J. (2014). Simple relation between Bayesian order-restricted and point-null hypothesis tests. Statistics & Probability Letters, 92, 121-124.
\item Morey, R. D., & Rouder, J. N. (2011). Bayes factor approaches for testing interval null hypotheses. Psychological methods, 16(4), 406.
}
}
\author{
Mattan S. Ben-Shachar
}
