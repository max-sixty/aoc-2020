using Memoize

str = read(open("Day-10.txt"), String)

ns = (
    str |>
    strip |>
    split .|>
    (x -> parse(Int, x)) |>
    sort |>
    x -> [0, x..., maximum(x) + 3]
)

diffs = diff(ns)

function groupby(a)
    out = Dict()
    [out[n] = get!(out, n, 0) + 1 for n in a]
    out
end

println(groupby(diffs) |> x -> x[3] * x[1])

@memoize function combinations(i)
    i == length(ns) && return 1
    return sum(combinations(j) for j in i+1:length(ns) if ns[j] - ns[i] <= 3)
end

println(combinations(1))
