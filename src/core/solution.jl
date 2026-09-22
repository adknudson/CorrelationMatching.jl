"""
    CorrelationMatchingSolution

Holds the result of a correlation matching solver along with diagnostic metadata.

# Fields
- `u`: Solved latent standard-normal correlation (`rho_Z` or `R_Z`).
- `resid`: Residual error(s) ``‖G(ρ_Z) - ρ_X‖``.
- `alg`: Algorithm used to solve the problem.
- `cache`: Pre-allocated solver workspace or pre-computed Cholesky factor `L`.
- `stats`: Diagnostic runtime statistics.
- `prob`: Reference to the originating `CorrelationMatchingProblem`.
- `retcode`: Convergence status symbol (`:Success`, `:MaxIters`, `:Infeasible`, etc.).
"""
struct CorrelationMatchingSolution{T, R, A, C, S, P}
    u::T
    resid::R
    alg::A
    cache::C
    stats::S
    prob::P
    retcode::Symbol
end

# Builder constructor
function build_correlation_solution(
        prob, alg, u, resid, cache;
        stats = nothing,
        retcode = :Success
    )
    return CorrelationMatchingSolution(u, resid, alg, cache, stats, prob, retcode)
end

function Base.show(io::IO, sol::CorrelationMatchingSolution)
    println(io, "CorrelationMatchingSolution")
    println(io, "  Return Code   : ", sol.retcode)
    println(io, "  Max Residual  : ", maximum(sol.resid))
    println(io, "  Solved u (Rz) :")
    return show(io, "text/plain", sol.u)
end
