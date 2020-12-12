using Pipe

str = read(open("Day-11.txt"), String)

seats = @pipe (
    readlines("Day-11.txt") .|>
    replace(_, r"#" => "O") |>
    [Symbol(_[i][j]) for i in eachindex(_), j in eachindex(_[begin])]
)

# Couldn't get `CartesianIndexes` to work
offsets = CartesianIndex.((i, j) for i = -1:1 for j in -1:1 if (i | j) != 0)

function iterate_1(seats)
    map(CartesianIndices(seats)) do index
        seat = seats[index]
        if seat == :.
            :.
        else
            # Can't broadcast over offsets as they're CartesianIndexes
            # https://github.com/JuliaLang/julia/issues/38432
            neighbours =
                [index + o for o in offsets] |> x -> filter(y -> checkbounds(Bool, seats, y), x)
            occupied_count = count(seats[neighbours] .== :O)

            if seat == :L && occupied_count == 0
                :O
            elseif seat == :O && occupied_count >= 4
                :L
            else
                seat
            end
        end
    end
end

function run_1(seats)
    while (seats_ = iterate_1(seats)) != seats
        seats = seats_
    end
    seats_
end

part_1 = count(run_1(seats) .== :O)
println(part_1)

function to_viewable(seats, index, offset)
    for i in Iterators.countfrom(1)
        ind = index + (offset * i)
        checkbounds(Bool, seats, ind) || return :.
        seats[ind] == :. || return seats[ind]
    end
end

function iterate_2(seats)
    map(CartesianIndices(seats)) do index
        seat = seats[index]
        if seat == :.
            :.

        else
            viewables = [to_viewable(seats, index, o) for o in offsets]
            occupied_count = count(viewables .== :O)

            if seat == :L && occupied_count == 0
                :O
            elseif seat == :O && occupied_count >= 5
                :L
            else
                seats[index]
            end
        end
    end
end

function run_2(seats)
    while (seats_ = iterate_2(seats)) != seats
        seats = seats_
    end
    seats_
end

finish2 = run_2(seats)
part2 = count(finish2 .== :O)

println(part2)
