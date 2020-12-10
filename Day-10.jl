using Memoize, SplitApplyCombine, Pipe

str = read(open("Day-10.txt"), String)

ns = @pipe str |> strip |> split .|> parse(Int, _) |> sort |> [0, _..., maximum(_) + 3]

part1 = @pipe ns |> diff |> groupcount(x -> x, _) |> _[1] * _[3]

println(part1)

@memoize function combinations(i)
    i == length(ns) && return 1
    return sum(combinations(j) for j in i+1:length(ns) if ns[j] - ns[i] <= 3)
end

part2 = combinations(1)

println(part2)