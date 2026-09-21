"""
    CorrelationMatchingProblem(dists, target; copula=GaussianCopula(), metric=PearsonCorrelation())

Defines a correlation matching problem for a set of marginal distributions and a target correlation
(either a scalar correlation for bivariate inputs or an N x N matrix for multivariate inputs).
"""
struct CorrelationMatchingProblem{D, T, C <: AbstractCopula, M <: AbstractCorrelationMetric}
    dists::D        # Tuple or Vector of UnivariateDistributions
    target::T       # Real (scalar) or AbstractMatrix{<:Real}
    copula::C       # Copula family (e.g. GaussianCopula())
    metric::M       # Correlation metric (e.g. PearsonCorrelation())
end

function CorrelationMatchingProblem(
        d1::UnivariateDistribution,
        d2::UnivariateDistribution,
        target::Real;
        copula::AbstractCopula = GaussianCopula(),
        metric::AbstractCorrelationMetric = PearsonCorrelation()
    )
    return CorrelationMatchingProblem((d1, d2), float(target), copula, metric)
end

function CorrelationMatchingProblem(
        dists,
        target::AbstractMatrix{<:Real};
        copula::AbstractCopula = GaussianCopula(),
        metric::AbstractCorrelationMetric = PearsonCorrelation()
    )
    n = length(dists)
    size(target) == (n, n) ||
        throw(
        DimensionMismatch(
            "Target correlation matrix size $(size(target)) must match number of distributions ($n)."
        )
    )
    return CorrelationMatchingProblem(dists, float.(target), copula, metric)
end

function CorrelationMatchingProblem(
        dists,
        target::Real;
        copula::AbstractCopula = GaussianCopula(),
        metric::AbstractCorrelationMetric = PearsonCorrelation()
    )
    length(dists) == 2 ||
        throw(
        DimensionMismatch(
            "Scalar target correlation requires exactly 2 marginal distributions. Got $(length(dists))"
        )
    )
    return CorrelationMatchingProblem(dists, float(target), copula, metric)
end


"""
    isbivariate(prob::CorrelationMatchingProblem)

Returns `true` if the problem specifies a scalar bivariate correlation match.
"""
isbivariate(::CorrelationMatchingProblem{<:Any, <:Real}) = true
isbivariate(::CorrelationMatchingProblem{<:Any, <:AbstractMatrix}) = false

"""
    dimension(prob::CorrelationMatchingProblem)

Returns the dimension `n` of the correlation matching problem.
"""
dimension(::CorrelationMatchingProblem{<:Any, <:Real}) = 2
dimension(prob::CorrelationMatchingProblem{<:Any, <:AbstractMatrix}) = length(prob.dists)
