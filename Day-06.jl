str = read(open("Day-06.txt"), String)

to_groups(str) = split(str |> strip, "\n\n")
to_people(group) = split(group, "\n")
to_answers(person) = split(person, "")

part1(group) = (
    group |>
    to_people |>
    (people -> to_answers.(people)) |>
    (answers -> union(answers...)) |>
    length
)

part2(group) = (
    group |>
    to_people |>
    (people -> to_answers.(people)) |>
    (answers -> interset(answers...)) |>
    length
)

groups = to_groups(str)
println(sum(part1.(groups)))
println(sum(part2.(groups)))
