f = open("Day-05.txt")

to_row(pass) = pass[1:7]
to_col(pass) = pass[8:10]

bo(c) = (c == 'B' || c == 'R') ? "1" : "0"
to_bools(row) = join(bo(c) for c in row)
to_num(bools) = parse(Int, bools, base = 2)

function seat_id(pass)
    row_num = pass |> to_row |> to_bools |> to_num
    col_num = pass |> to_col |> to_bools |> to_num
    row_num * 8 + col_num
end

passes = readlines(f)
ids = seat_id.(passes) |> sort

println(maximum(ids))

function get_my_seat()
    for i = minimum(ids):maximum(ids)
        if (i - 1 in ids && i + 1 in ids && !(i in ids))
            return i
        end
    end
end

println(get_my_seat())

