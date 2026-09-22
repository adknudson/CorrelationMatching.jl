# AGENTS.md

Guidance for AI agents working in the CorrelationMatching.jl repository.

## Overview

CorrelationMatching.jl is a Julia package. Source lives in `src/` and tests in `test/`.

## Distributions.jl

This package depends on `Distributions.jl` for its distributions interface. Whenever uncertain about their API, check the docs at <https://juliastats.org/Distributions.jl>

Most of this package only relies on a few types:

- `UnivariateDistribution`
  - `ContinuousUnivariateDistribution`
  - `DiscreteUnivariateDistribution`

When writing unit tests, ensure that the following cases are considered:

- Continuous distributions
- Discrete distributions
- Mix of continuous and discrete distributions

Use a small set of common distributions for testing:

- Continuous
  - `Normal(mean, std)`
  - `LogNormal(logmean, scale)`
  - `Gamma(shape, scale)`
  - `Beta(a, b)`
- Discrete
  - `Binomial(n, p)`
  - `Poisson(rate)`
  - `NegativeBinomial(r, p)`

The following distributions are useful for testing edge cases:

- `Cauchy(location, scale)` (has undefined variance)
- `FDist(d1, d2)` (has undefined mean for `d2 <= 2`, and has undefined variance for `d2 <= 4`)

## Development commands

- **Test**: `julia --project=. -e "using Pkg; Pkg.test()"`
- **REPL with the project active**: `julia --project=.`

## Conventions

- Match the existing code style in `src/`.
- Add or update tests in `test/` for any behavior change.
- Keep public API changes documented.
