f = open("Day-02.txt")

lines = readlines(f)

regex = r"(\d+)-(\d+)\s(\w):\s(\w+)"

# Part 1

tot = 0
for l in lines
    min, max, char, password = match(regex, l).captures
    min = parse(Int, min)
    max = parse(Int, max)
    count = sum([1 for _ = eachmatch(Regex(char), password)])

    # Maybe better to make a function and then evaluate it
    # like the line above, rather than this `global` var?
    if min <= count <= max
        global tot += 1
    end
end

println(tot)

# Part 2

tot = 0
for l in lines
    min, max, char, password = match(regex, l).captures
    min = parse(Int, min)
    max = parse(Int, max)
    
    # min:min is required, otherwise we get a Char type
    if xor(password[min:min] == char, password[max:max] == char) 
        global tot += 1
    end
end

println(tot)


