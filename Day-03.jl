f = open("Day-03.txt")
lines = readlines(f)

parse_to_bool(c) = string(c) == "#"

height = length(lines)
width = length(first(lines))

A = falses(height, width)

# Can we do this with an iterator? It's somewhat awkward to 
# define a fixed-sized array and then iterate over both
# dimensions.
for i = 1:height
    line = lines[i]
    for j = 1:width
        bo = parse_to_bool(line[j])
        A[i, j] = bo
    end
end

function count_trees(array, x_step, y_step)
    ts = 0

    # Is there an indexer object?
    loc = (1, 1)
    while true
        ts += array[loc...]
        y, x = loc
        # What's a better way to do the mod of a 1-indexed number?
        x = x - 1
        x = mod(x + x_step, width)
        x = x + 1
        y += y_step
        if y > height
            break
        end
        loc = (y, x)
    end
    ts
end

println(count_trees(A, 3, 1))

println(
    count_trees(A, 1, 1) *
    count_trees(A, 3, 1) *
    count_trees(A, 5, 1) *
    count_trees(A, 7, 1) *
    count_trees(A, 1, 2),
)

