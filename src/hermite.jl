# Cache for Gauss-Hermite quadrature rules: m => (nodes, weights)
const GLOBAL_GH_CACHE = Dict{Int, Tuple{Vector{Float64}, Vector{Float64}}}()

"""
    probabilist_hermite(k, x)

Evaluates the `k`-th order probabilist's Hermite polynomial at `x`.
"""
function probabilist_hermite(k::Int, x::Real)
    k < 0 && return zero(x)
    k == 0 && return one(x)
    k == 1 && return x

    h_prev2 = one(x)
    h_prev1 = x
    h_curr = x
    for i in 2:k
        h_curr = x * h_prev1 - (i - 1) * h_prev2
        h_prev2 = h_prev1
        h_prev1 = h_curr
    end

    return h_curr
end

"""
    gauss_hermite_prob(m)

Generates m-point Gauss-Hermite nodes and weights for integrating against
the standard normal PDF: ∫ f(x)ϕ(x)dx ≈ Σ w_i f(t_i).
Uses the Golub-Welsch algorithm.
"""
function gauss_hermite_prob(m::Int)
    # Jacobi matrix for normalized probabilist's Hermite polynomials
    J = SymTridiagonal(zeros(m), sqrt.(1:(m - 1)))
    vals, vecs = eigen(J)
    nodes = vals
    weights = vecs[1, :] .^ 2 # First row elements squared represent weights
    return nodes, weights
end

"""
    get_gauss_hermite(m)

Retrieves or computes Gauss-Hermite nodes and weights for m points.
Dynamically updates the global dictionary in a thread-safe manner.
"""
function get_gauss_hermite(m::Int)
    # Fast path: Read without lock if already present
    if haskey(GLOBAL_GH_CACHE, m)
        return GLOBAL_GH_CACHE[m]
    end

    # Slow path: Compute and cache under lock
    return lock(CACHE_LOCK) do
        return get!(GLOBAL_GH_CACHE, m) do
            gauss_hermite_prob(m)
        end
    end
end
