module CorrelationMatching

using Distributions
using LinearAlgebra
using CommonSolve

abstract type AbstractCorrelationMatric end

struct PearsonCorrelation <: AbstractCorrelationMatric end
struct SpearmanCorrelation <: AbstractCorrelationMatric end
struct KendallCorrelation <: AbstractCorrelationMatric end

abstract type AbstractCopula end
struct GaussianCopula <: AbstractCopula end

include("core/problem.jl")
include("core/solution.jl")

end
