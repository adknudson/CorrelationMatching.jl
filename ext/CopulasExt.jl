module CopulasExt

using CorrelationMatching
using Copulas
using Distributions

function Copulas.GaussianCopula(
        dists,
        Rx::AbstractMatrix{<:Real};
        alg = Xiao2018(),
        kwargs...
    )
    prob = CorrelationMatchingProblem(dists, Rx)
    sol = solve(prob, alg; kwargs...)
    return GaussianCopula(sol.u)
end

function Copulas.SklarDist(
        dists,
        Rx::AbstractMatrix{<:Real};
        alg = Xiao2018(),
        kwargs...
    )
    C = GaussianCopula(dists, Rx; alg = alg, kwargs...)
    return SklarDist(C, Tuple(dists))
end

Copulas.GaussianCopula(sol::CorrelationMatchingSolution) = GaussianCopula(sol.u)

function Copulas.SklarDist(sol::CorrelationMatchingSolution)
    C = GaussianCopula(sol)
    return SklarDist(C, Tuple(sol.prob.dists))
end

end
