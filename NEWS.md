# bayestestR 0.3.2

## New functions / features

- `format_bf()` moved from parameters to bayestestR
- `distribution_binomial()` for perfect binomial distributions
- `simulate_correlation()` Simulate correlated datasets
- `p_significance()` Compute the probability of Practical Significance (ps)
- `overlap()` Compute overlap between two empirical distributions
- `estimate_density()`: `method = "mixture"` argument added for mixture density estimation

## Bug fixes

- Fixed bug in `simulate_prior()` for stanreg-models when `autoscale` was set to `FALSE`

# bayestestR 0.3.0

## General

- revised `print()`-methods for functions like `rope()`, `p_direction()`, `describe_posterior()` etc., in particular for model objects with random effects and/or zero-inflation component

## New functions / features

- `check_prior()` to check if prior is informative
- `simulate_prior()` to simulate model's priors as distributions
- `distribution_gamma()` to generate a (near-perfect or random) Gamma distribution
- `contr.bayes` function for orthogonal factor coding (implementation from Singmann & Gronau's [`bfrms`](https://github.com/bayesstuff/bfrms/), used for proper prior estimation when factor have 3 levels or more. See Bayes factor vignette
## Changes to functions

- Added support for `sim`, `sim.merMod` (from `arm::sim()`) and `MCMCglmm`-objects to many functions (like `hdi()`, `ci()`, `eti()`, `rope()`, `p_direction()`, `point_estimate()`, ...)
- `describe_posterior()` gets an `effects` and `component` argument, to include the description of posterior samples from random effects and/or zero-inflation component.
- More user-friendly warning for non-supported models in `bayesfactor()`-methods

## Bug fixes

- Fixed bug in `bayesfactor_inclusion()` where the same interaction sometimes appeared more than once (#223)
- Fixed bug in `describe_posterior()` for *stanreg* models fitted with fullrank-algorithm

# bayestestR 0.2.5

## Breaking changes

- `rope_range()` for binomial model has now a different default (-.18; .18 ; instead of -.055; .055)
- `rope()`: returns a proportion (between 0 and 1) instead of a value between 0 and 100
- `p_direction()`: returns a proportion (between 0.5 and 1) instead of a value between 50 and 100 ([#168](https://github.com/easystats/bayestestR/issues/168))
- `bayesfactor_savagedickey()`: `hypothesis` argument replaced by `null` as part of the new `bayesfactor_parameters()` function

## New functions / features

- `density_at()`, `p_map()` and `map_estimate()`: `method` argument added
- `rope()`: `ci_method` argument added
- `eti()`: Computes equal-tailed intervals
- `reshape_ci()`: Reshape CIs between wide/long
- `bayesfactor_parameters()`: New function, replacing `bayesfactor_savagedickey()`, allows for computing Bayes factors against a *point-null* or an *interval-null*
- `bayesfactor_restricted()`: Function for computing Bayes factors for order restricted models

## Minor changes

## Bug fixes

- `bayesfactor_inclusion()` now works with `R < 3.6`.

# bayestestR 0.2.2

## Breaking changes

- `equivalence_test()`: returns capitalized output (e.g., `Rejected` instead of `rejected`)
- `describe_posterior.numeric()`: `dispersion` defaults to `FALSE` for consistency with the other methods

## New functions / features

- `pd_to_p()` and `p_to_pd()`: Functions to convert between probability of direction (pd) and p-value
- Support of `emmGrid` objects: `ci()`, `rope()`, `bayesfactor_savagedickey()`, `describe_posterior()`, ...


## Minor changes

- Improved tutorial 2

## Bug fixes

- `describe_posterior()`: Fixed column order restoration
- `bayesfactor_inclusion()`: Inclusion BFs for matched models are more inline with JASP results.

# bayestestR 0.2.0

## Breaking changes

- plotting functions now require the installation of the `see` package
- `estimate` argument name in `describe_posterior()` and `point_estimate()` changed to `centrality`
- `hdi()`, `ci()`, `rope()` and `equivalence_test()` default `ci` to `0.89`
- `rnorm_perfect()` deprecated in favour of `distribution_normal()`
- `map_estimate()` now returns a single value instead of a dataframe and the `density` parameter has been removed. The MAP density value is now accessible via `attributes(map_output)$MAP_density`

## New functions / features

- `describe_posterior()`, `describe_prior()`, `diagnostic_posterior()`: added wrapper function
- `point_estimate()` added function to compute point estimates
- `p_direction()`: new argument `method` to compute pd based on AUC
- `area_under_curve()`: compute AUC
- `distribution()` functions have been added
- `bayesfactor_savagedickey()`, `bayesfactor_models()` and `bayesfactor_inclusion()` functions has been added
- Started adding plotting methods (currently in the [`see`](https://github.com/easystats/see) package) for `p_direction()` and `hdi()`
- `probability_at()` as alias for `density_at()`
- `effective_sample()` to return the effective sample size of Stan-models
- `mcse()` to return the Monte Carlo standard error of Stan-models

## Minor changes

- Improved documentation
- Improved testing
- `p_direction()`: improved printing
- `rope()` for model-objects now returns the HDI values for all parameters as attribute in a consistent way
- Changes legend-labels in `plot.equivalence_test()` to align plots with the output of the `print()`-method (#78)

## Bug fixes

- `hdi()` returned multiple class attributes (#72)
- Printing results from `hdi()` failed when `ci`-argument had fractional parts for percentage values (e.g. `ci = .995`).
- `plot.equivalence_test()` did not work properly for *brms*-models (#76).

# bayestestR 0.1.0

- CRAN initial publication and [0.1.0 release](https://github.com/easystats/bayestestR/releases/tag/v0.1.0)
- Added a `NEWS.md` file to track changes to the package
