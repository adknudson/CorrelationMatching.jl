# CorrelationMatching

[![Stable Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://adknudson.github.io/CorrelationMatching.jl/stable)
[![Development documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://adknudson.github.io/CorrelationMatching.jl/dev)
[![Test workflow status](https://github.com/adknudson/CorrelationMatching.jl/actions/workflows/Test.yml/badge.svg?branch=main)](https://github.com/adknudson/CorrelationMatching.jl/actions/workflows/Test.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/adknudson/CorrelationMatching.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/adknudson/CorrelationMatching.jl)
[![Docs workflow Status](https://github.com/adknudson/CorrelationMatching.jl/actions/workflows/Docs.yml/badge.svg?branch=main)](https://github.com/adknudson/CorrelationMatching.jl/actions/workflows/Docs.yml?query=branch%3Amain)
[![BestieTemplate](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/JuliaBesties/BestieTemplate.jl/main/docs/src/assets/badge.json)](https://github.com/JuliaBesties/BestieTemplate.jl)

## Overview

- Wish to specify a joint distribution with desired correlation structure
- Need to identify a latent copula correlation such that simulated data has the desired correlation
- There are several correlation metrics (Pearson, Spearman, Kendall)
- There are several copula types (Gaussian being very common)
- There are several methods for estimating the latent copula correlation

## TODO

### Package Framework

- [ ] Problem type
- [ ] Correlation metric type
- [ ] Copula type
- [ ] Solution type
- [ ] Algorithm type

### Algorithms

- [ ] Xiao2018
- [ ] Chen2001
- [ ] \[Quasi\] Monte Carlo
- [ ] Linear Programming (JuMP)
- [ ] Numerical Integration
- [ ] Exact matching

### Extensions

- [ ] Copulas.jl
- [ ] JuMP.jl

## Details

### Pearson Correlation Matching via a Gaussian Copula
