
using Underscores, StatsBase, Base.Iterators

input = read(open("Day-24.txt"), String) |> strip

import Hexagons

directions = map(split(input, "\n")) do d
    i = 1
    ds = []
    while i <= length(d)
        if d[i] in ['s', 'n']
            push!(ds, d[i:i+1])
            i += 2
        else
            push!(ds, d[i:i])
            i += 1
        end
    end
    ds
end

direction_map = zip(["ne", "e", "se", "sw", "w", "nw"], 1:6) |> Dict

function to_destinations(moves)
    current = Hexagons.HexagonCubic(0, 0, 0)
    move_coords = @_ direction_map[_].(moves)

    map(move_coords) do m
        current = Hexagons.neighbor(current, m)
    end
    current
end

black_tiles =
    @_ to_destinations.(directions) |> countmap |> [t for (t, n) in __ if isodd(n)]

part_1 = black_tiles |> length |> println

all_neighbors(tiles) = Hexagons.neighbors.(tiles) |> flatten |> unique

to_neighbor_count(tile, black_tiles) =
    @_ Hexagons.neighbors(tile) .|> (_ in black_tiles) |> count

function run_round(black_tiles)
    current = deepcopy(black_tiles)
    potentials = union(all_neighbors(current), black_tiles)

    next = map(potentials) do t
        n_count = to_neighbor_count(t, current)
        is_black = t in current
        t => if is_black && (n_count == 0 || n_count > 2)
            false
        elseif !is_black && (n_count == 2)
            true
        else
            is_black
        end
    end

    return [t for (t, is_black) in next if is_black]
end

function run_2(black_tiles)
    [black_tiles = run_round(black_tiles) for _ = 1:100]
    black_tiles
end

run_2(black_tiles) |> length |> println
