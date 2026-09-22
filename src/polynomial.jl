"""
    eval_poly(coefs, z)

Evaluates the polynomial at `z` given its coefficients.
"""
function eval_poly(coefs::Vector{T}, z::S) where {T <: Real, S <: Real}
    TS = promote_type(T, S)
    val = zero(TS)
    z_pow = one(TS)
    for ci in coefs
        z_pow *= z
        val += ci * z_pow
    end
    return val
end
