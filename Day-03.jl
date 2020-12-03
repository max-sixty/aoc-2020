f = open("Day-03.txt")
lines = readlines(f)

parse_to_bool(c) = string(c) == "#"

height = length(lines)
width = length(first(lines))

A = falses(height, width)

# Can we do this with an iterator? It's somewhat awkward to 
# define a fixed-sized array and then iterate over both
# dimensions.
for i = 1:height, j = 1:width
    A[i, j] = parse_to_bool(lines[i][j])
end

function count_trees(array, x_step, y_step)
    ts = 0

    # In retrospect, probably not worth using the CartesianIndex; tuple would
    # have been fine

    loc = CartesianIndex(1, 1)

    while loc[1] <= height
        ts += array[loc]
        loc = CartesianIndex(loc[1] + y_step, mod1(loc[2] + x_step, width))
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

