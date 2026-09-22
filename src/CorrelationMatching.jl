module CorrelationMatching

using Distributions
using LinearAlgebra
using CommonSolve

abstract type AbstractTargetCorrelation end

struct Pearson <: AbstractTargetCorrelation end
struct KendallTau <: AbstractTargetCorrelation end
struct SpearmanRho <: AbstractTargetCorrelation end

abstract type AbstractCopula end
struct GaussianCopula <: AbstractCopula end

include("hermite.jl")
include("factorial.jl")
include("polynomial.jl")

include("core/problem.jl")

end
