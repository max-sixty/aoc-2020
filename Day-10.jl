using Memoize, Pipe, StatsBase

str = read(open("Day-10.txt"), String)
ns = @pipe str |> strip |> split .|> parse(Int, _) |> sort |> [0, _..., maximum(_) + 3]

part1 = @pipe ns |> diff |> countmap |> _[1] * _[3]
println(part1)

@memoize function n_combos(i)
    i == length(ns) && return 1
    sum(n_combos(j) for j in i+1:length(ns) if ns[j] - ns[i] <= 3)
end

part2 = n_combos(1)
println(part2)