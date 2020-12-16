
fields_str, my_ticket_str, nearby_tickets_str =
    read(open("Day-16.txt"), String) |> x -> split(x, "\n\n") .|> strip

fields = map(split(fields_str, "\n")) do x
    r = match(r"(.*): (\d+)-(\d+) or (\d+)-(\d+)", x).captures
    name = r[1]
    low1, high1, low2, high2 = parse.(Int, r[2:end])
    (; name, ranges = [low1:high1, low2:high2])
end

to_tickets(ticket_str) =
    split(ticket_str, "\n")[2:end] .|> x -> split(x, ",") .|> x -> parse(Int, x)

nearby_tickets = to_tickets(nearby_tickets_str)

my_ticket = to_tickets(my_ticket_str)[begin]

is_valid(n, f) = any(n .∈ f.ranges)

part_1 = sum(n for ticket in nearby_tickets for n in ticket if !any(is_valid.(n, fields)))
@show part_1

# Potentially could have made a 2D array for the tickets x fields.

is_valid_ticket(t) = all(any(is_valid.(n, fields)) for n in t)
correct_nearby_tickets = filter(is_valid_ticket, nearby_tickets)

correct_tickets = [correct_nearby_tickets..., my_ticket]

valid_positions =
    map(fields) do field
        field.name => filter(eachindex(my_ticket)) do i
            (correct_tickets .|> x -> is_valid(x[i], field)) |> all
        end
    end |> Dict

function to_final_positions(valid_positions)
    valid_positions = deepcopy(valid_positions)
    final_positions = Dict()

    while length(valid_positions) > 0
        field, only_option =
            only((k, only(v)) for (k, v) in valid_positions if length(v) == 1)

        pop!(valid_positions, field)
        final_positions[field] = only_option

        filter!.(!=(only_option), values(valid_positions))
    end

    final_positions
end

final_positions = to_final_positions(valid_positions)

part_2 = prod(my_ticket[v] for (k, v) in final_positions if occursin("departure", k))
@show part_2
