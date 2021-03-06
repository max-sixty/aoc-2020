f = open("Day-04.txt")

lines = split(strip(read(f, String)), "\n\n")

regex = r"(\w+):(\S+)"
kv(entry) = match(regex, entry).captures
tags(line) = kv.(split(line, r" |\n")) |> Dict

passports = tags.(lines)

all_cats = ["eyr", "byr", "hcl", "cid", "ecl", "hgt", "iyr", "pid"]
required_cats = Set(["eyr", "byr", "hcl", "ecl", "hgt", "iyr", "pid"])

is_complete(passport) = issubset(required_cats, keys(passport))

println(is_complete.(passports) |> sum)

is_height_valid(hgt) = (
    if occursin("cm", hgt)
        (150 <= parse(Int, match(r"(\d+)", hgt).captures[1]) <= 193)
    else
        (59 <= parse(Int, match(r"(\d+)", hgt).captures[1]) <= 76)
    end
)

function is_valid(passport)
    # Another option would have been a dict of functions
    (
        true &&
        is_complete(passport) &&
        1920 <= parse(Int, passport["byr"]) <= 2002 &&
        match(r"^\d{4}$", passport["byr"]) |> !isnothing &&
        2010 <= parse(Int, passport["iyr"]) <= 2020 &&
        match(r"^\d{4}$", passport["iyr"]) |> !isnothing &&
        2020 <= parse(Int, passport["eyr"]) <= 2030 &&
        match(r"^\d{4}$", passport["eyr"]) |> !isnothing &&
        is_height_valid(passport["hgt"]) &&
        match(r"^#[0-9a-f]{6}$", passport["hcl"]) |> !isnothing &&
        occursin(passport["ecl"], "amb blu brn gry grn hzl oth") &&
        match(r"^\d{9}$", passport["pid"]) |> !isnothing
    )
end

println(is_valid.(passports) |> sum)
