f = open("Day-01.txt")

numbers = sort!([parse(Int, n) for n in readlines(f)])

# Part 1

for i in numbers
    remainder = 2020 - i
    remainder_loc = searchsorted(numbers, remainder)
    # Is there a better way of asking "is the range empty"?
    if remainder_loc.start == remainder_loc.stop
        println(i * numbers[remainder_loc])
    end
end

# Part 2

# This is so fast that it's not needed to make more efficient for this
# inputs size, but I'm sure without too much genius we could make
# it more efficient.
#
# For example, we could start j from where i is, to avoid repeating
# pairs.

for i in numbers
    for j in numbers
        remainder = 2020 - i - j
        remainder_loc = searchsorted(numbers, remainder)
        if remainder_loc.start == remainder_loc.stop
            println(i * j * numbers[remainder_loc])
        end
    end
end


