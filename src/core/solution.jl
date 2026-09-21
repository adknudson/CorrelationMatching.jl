struct CorrelationMatchingSolution{X, R, A, C, S}
    x::X
    resid::R
    alg::A
    cache::C
    stats::S
end

function build_correlation_solution(
        alg, x, resid, cache;
        stats = nothing
    )
    return CorrelationMatchingSolution{
        typeof(x), typeof(resid), typeof(alg), typeof(cache), typeof(stats),
    }(
        x,
        resid,
        alg,
        cache,
        stats
    )
end
