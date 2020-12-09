
str = read(open("Day-09.txt"), String)

numbers = str |> strip |> split .|> x -> parse(Int, x)

function is_in_preamble(n, preamble)
    for m in preamble
        remainder = n - m
        remainder in preamble && return true
    end
    return false
end

function part1(numbers, len)
    # I've seen this be done elegantly if inefficiently with combinatorics.
    for i = (len+1):length(numbers)
        n = numbers[i]
        preamble = numbers[(i-len):(i-1)]
        is_in_preamble(n, preamble) || return n
    end
end

p1 = part1(numbers, 25)

println(p1)

function part2(target)
    i = j = 1
    # Could write this to avoid summing over the whole list each time.
    while (acc = sum(numbers[i:j])) != target
        acc < target ? j += 1 : i += 1
    end
    sum(extrema(numbers[i:j]))
end

println(part2(p1))
