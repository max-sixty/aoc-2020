using Underscores, StatsBase, Base.Iterators

input = read(open("Day-25.txt"), String) |> strip

numbers = @_ input |> split(__, "\n") |> parse(Int, _).(__)

function transform(sn, loop_size)
    value = 1
    [value = (value * sn) % 20201227 for _ = 1:loop_size]
    value
end

function to_loop_size(sn, target)
    value = 1
    for x in countfrom(1)
        value = (value * sn) % 20201227
        value == target && return x
    end
end

loop_sizes = to_loop_size.(7, numbers)
transform(numbers[2], loop_sizes[1]) |> println
transform(numbers[1], loop_sizes[2]) |> println
