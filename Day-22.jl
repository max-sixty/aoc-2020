using Underscores, StatsBase, Base.Iterators

input = read(open("Day-22.txt"), String) |> strip

decks_str = @_ input |> split(__, "\n\n")

decks = map(decks_str) do player
    lines = split(player, "\n")
    @_ lines[2:end] .|> parse(Int, _)
end

hash_decks(decks) = [[decks[1]..., 0, decks[2]...]]
copy_cards(deck) = copy(deck[2:(deck[1]+1)])
is_too_short(deck) = deck[1] > length(deck) - 1

function play_recurse_game(decks, history)

    history = deepcopy(history)
    decks = deepcopy(decks)

    while all(length.(decks) .> 0)

        if hash_decks(decks) in history
            return 1, decks
        end

        push!(history, hash_decks(decks))

        if any(is_too_short.(decks))
            winner = decks[1][1] > decks[2][1] ? 1 : 2
        else
            winner, _ = play_recurse_game(copy_cards.(decks), Set())
        end

        if winner == 1
            push!(decks[1], decks[1][1], decks[2][1])
        else
            push!(decks[2], decks[2][1], decks[1][1])
        end

        deleteat!.(decks, 1)
    end
    winner = length(decks[1]) > length(decks[2]) ? 1 : 2
    winner, decks
end

winner, ending = play_recurse_game(decks, Set())

(ending[winner] |> reverse) .* (1:length(ending[winner])) |> sum |> println
