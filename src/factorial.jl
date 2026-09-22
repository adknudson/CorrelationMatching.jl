const FACT_LOCK = ReentrantLock()

inv_factorial(k::Int) = Float64(inv(factorial(big(k))))

# Precompute 1/k! up to a reasonable default
const GLOBAL_INV_FACTORIALS = [inv_factorial(k) for k in 1:60]

"""
    get_inv_factorials(max_k)

Retrieves precomputed 1/k! values up to degree `max_k`.
Dynamically extends the global vector in a thread-safe manner if max_k > current length.
"""
function get_inv_factorials(max_k::Int)
    if max_k > length(GLOBAL_INV_FACTORIALS)
        lock(FACT_LOCK) do
            current_len = length(GLOBAL_INV_FACTORIALS)
            if max_k > current_len
                for k in (current_len + 1):max_k
                    f = inv_factorial(k)
                    push!(GLOBAL_INV_FACTORIALS, f)
                end
            end
        end
    end
    return @view GLOBAL_INV_FACTORIALS[1:max_k]
end
