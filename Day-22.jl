using Underscores, StatsBase, Base.Iterators

input = read(open("Day-22.txt"), String) |> strip

decks_str = @_ input |> split(__, "\n\n")

decks = map(decks_str) do player
    lines = split(player, "\n")
    @_ lines[2:end] .|> parse(Int, _)
end

copy_cards(deck) = copy(deck[2:(deck[1]+1)])
is_too_short(deck) = deck[1] > length(deck) - 1

function play_recurse_game(decks, history)

    history = deepcopy(history)
    decks = deepcopy(decks)

    while all(length.(decks) .> 0)

        hash(decks) ∈ history && return 1, decks

        push!(history, hash(decks))

        if any(is_too_short.(decks))
            winner = decks[1][1] > decks[2][1] ? 1 : 2
        else
            winner, _ = play_recurse_game(copy_cards.(decks), Set())
        end

        c1, c2 = popfirst!.(decks)
        if winner == 1
            push!(decks[1], c1, c2)
        else
            push!(decks[2], c2, c1)
        end

    end
    winner = length(decks[1]) > length(decks[2]) ? 1 : 2
    winner, decks
end

winner, ending = play_recurse_game(decks, Set())

(ending[winner] |> reverse) .* (1:length(ending[winner])) |> sum |> println
