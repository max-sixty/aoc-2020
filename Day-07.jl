str = read(open("Day-07.txt"), String) |> strip |> x -> split(x, "\n")

function to_parsed(line)
    bag, tails_str = match(r"([\w\s]*) bags contain (.*)", line).captures

    # We could probably avoid this special case — have no tail_str?
    if occursin("no other", tails_str)
        return (; bag, contents = Array[])
    end

    contents_pairs = map(split(tails_str, r",")) do tail_str
        n, b = match(r"[\s]*(\d+) ([\w\s]*)[\s]bag", tail_str).captures
        Pair(b, parse(Int, n))
    end

    return (; bag, contents = Dict(contents_pairs))
end

entries = Dict(e.bag => e.contents for e in to_parsed.(str))

our_bag = "shiny gold"

function is_our_bag_contained(bag)
    entry = entries[bag]
    if our_bag in keys(entry)
        return true
    end
    return any(is_our_bag_contained(b) for b in keys(entry))
end

println(sum(is_our_bag_contained(bag) for bag in keys(entries)))

function count_bags_inside(bag)
    bags_inside = entries[bag]
    if length(bags_inside) == 0
        return 1
    end
    # The current bag (1) +, for each contained bag, the number of 
    # those bags * the number of bags it contains
    return 1 + sum(b.second * count_bags_inside(b.first) for b in bags_inside)
end

# -1 since we don't count our own bag
println(count_bags_inside(our_bag) - 1)
