using Underscores, StatsBase, Base.Iterators

input = read(open("Day-21.txt"), String) |> strip

foods = map(split(input, "\n")) do l
    ingredients_str, allergens_str = match(r"(.*) \(contains (.*)\)", l).captures
    ingredient = split(ingredients_str |> strip, " ")
    allergen = split(allergens_str |> strip, ", ")
    (; ingredient, allergen)
end

ingredients_count = @_ foods .|> _.ingredient |> flatten |> countmap
allergens_count = @_ foods .|> _.allergen |> flatten |> countmap

shortlists = map(allergens_count |> keys |> collect) do a
    foods_matching = @_ filter(a in _.allergen, foods)
    a => intersect([f.ingredient for f in foods_matching]...)
end |> Dict

potential_contain_allergens = shortlists |> values |> flatten |> unique
cannot_contain = @_ ingredients_count |> keys |> setdiff(__, potential_contain_allergens)

part_1 = sum(c for (f, c) in ingredients_count if f in cannot_contain)
println(part_1)

function to_map(shortlists)
    result = Dict()
    shortlists = copy(shortlists)

    while length(shortlists) > 0
        allergen = @_ filter(length(_[2]) == 1, shortlists) |> first |> __[1]

        only_option = pop!(shortlists, allergen) |> only
        result[allergen] = only_option
        filter!.(!=(only_option), values(shortlists))
    end
    result
end

mapping = to_map(shortlists)
part_2 = @_ mapping |> collect |> sort(__, by = _[1]) |> map(_[2], __) |> join(__, ",")

println(part_2)