str = "2,15,0,9,1,20"

numbers = str |> x -> split(x, ",") .|> x -> parse(Int, x)

function run(numbers, n)

    preface = numbers[begin:(end-1)]

    last_seen = Dict(v => k for (k, v) in enumerate(preface))

    prev = numbers[end]

    for i = (length(numbers)+1):n
        prev_prev = get(last_seen, prev, 0)
        current = if prev_prev == 0
            0
        else
            (i - 1) - prev_prev
        end

        last_seen[prev] = i - 1

        prev = current

    end
    prev

end

@time run(numbers, 2020)

@time run(numbers, 30000000)
