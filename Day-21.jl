using Underscores, StatsBase, Base.Iterators

input = read(open("Day-21.txt"), String) |> strip

foods = map(split(input, "\n")) do l
    foods_str, allergens_str = match(r"(.*) \(contains (.*)\)", l).captures
    food = split(foods_str |> strip, " ")
    allergen = split(allergens_str |> strip, ", ")
    (; food, allergen)
end

all_foods = @_ foods .|> _.food |> flatten |> countmap
all_allergens = @_ foods .|> _.allergen |> flatten |> countmap

shortlists = map(all_allergens |> keys |> collect) do a
    allergen_matching = [f for f in foods if a in f.allergen]
    a => intersect([f.food for f in allergen_matching]...)
end |> Dict

function to_food_allergen_map(shortlists)
    result = Dict()

    shortlists = deepcopy(shortlists)

    while length(shortlists) > 0
        allergen = @_ filter(length(_[2]) == 1, shortlists) |> first |> __[1]

        only_option = pop!(shortlists, allergen) |> only
        result[allergen] = only_option
        filter!.(!=(only_option), values(shortlists))
    end
    result
end

mapping = to_food_allergen_map(shortlists)
potential_contain_allergens = shortlists |> values |> flatten |> unique
cannot_contain = @_ all_foods |> keys |> setdiff(__, potential_contain_allergens)

part_1 = sum(c for (f, c) in all_foods if f in cannot_contain)
part_2 = @_ mapping |> collect |> sort(__, by = _[1]) |> map(_[2], __) |> join(__, ",")

println(part_1)
println(part_2)


