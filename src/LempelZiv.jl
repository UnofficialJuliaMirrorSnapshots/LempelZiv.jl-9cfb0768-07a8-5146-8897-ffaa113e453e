#!/usr/bin/env julia
"""Lempel-Ziv complexity for a binary sequence, in naive Julia code.

- How to use it? From Julia, it's easy:

julia> using LempelZiv
julia> s = "1001111011000010"
julia> LempelZiv.lempel_ziv_complexity(s)  # 1 / 0 / 01 / 1110 / 1100 / 0010
6


- Run this .jl file with an argument "test" to run a small benchmark (100 strings of size 10000).
- Note: there is also a Python version, if you need.

- MIT Licensed, (C) 2017 Lilian Besson (Naereen)
  https://GitHub.com/Naereen/LempelZiv.jl
"""

__author__ = "Lilian Besson (Naereen)"
__version__ = "0.0.1"


module LempelZiv
export lempel_ziv_complexity

"""
    lempel_ziv_complexity(binary_sequence)

Returns the Lempel-Ziv complexity for a binary sequence, in naive Julia code.

- How to use it? From Julia, it's easy:

```julia
julia> using LempelZiv
julia> s = "1001111011000010"
julia> LempelZiv.lempel_ziv_complexity(s)  # 1 / 0 / 01 / 1110 / 1100 / 0010
6
```

- [MIT Licensed](https://lbesson.mit-license.org)
  (C) 2017 Lilian Besson (Naereen)
  See [Naereen/LempelZiv.jl](https://GitHub.com/Naereen/LempelZiv.jl)
"""
function lempel_ziv_complexity(binary_sequence)
    u, v, w = 0, 1, 1
    v_max = 1
    size = length(binary_sequence)
    complexity = 1
    while true
        if binary_sequence[u + v] == binary_sequence[w + v]
            v += 1
            if w + v >= size
                complexity += 1
                break
            end
        else
            if v > v_max
                v_max = v
            end
            u += 1
            if u == w
                complexity += 1
                w += v_max
                if w > size
                    break
                else
                    u = 0
                    v = 1
                    v_max = 1
                end
            else
                v = 1
            end
        end
    end
    return complexity
end

end


if "test" in ARGS
    # import LempelZiv
    s = "1001111011000010"
    # LempelZiv.lempel_ziv_complexity(s)  # 1 / 0 / 01 / 1110 / 1100 / 0010
    println("For s = ", s, " its Lempel-Ziv Complexity is = ", LempelZiv.lempel_ziv_complexity(s))

    M = 100;
    N = 5000;
    for _ in 1:M
        s = join(rand(0:1, rand(N:10*N)));
        println("For a random string s of size = ", length(s), " its Lempel-Ziv Complexity is = ", LempelZiv.lempel_ziv_complexity(s))
        println(@time LempelZiv.lempel_ziv_complexity(s))
    end
end
