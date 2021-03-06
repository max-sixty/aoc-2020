
str = (read(open("Day-08.txt"), String) |> strip |> x -> split(x, "\n"))

instructions = map(str) do x
    op, num = split(x, " ")
    (; op = Symbol(op), n = parse(Int, num))
end

@enum Exit cycle complete

function run(instructions)
    ptr = 1
    acc = 0
    history = Set()
    while true
        ptr == length(instructions) + 1 && return complete, acc
        ptr in history && return cycle, acc
        push!(history, ptr)
        current = instructions[ptr]
        if current.op == :nop
            ptr += 1
        elseif current.op == :acc
            acc += current.n
            ptr += 1
        elseif current.op == :jmp
            ptr += current.n
        end
    end
end

function part1()
    _, acc = run(instructions)
    acc
end

function part2()
    for i in eachindex(instructions)
        inst = instructions[i]
        instructions_ = copy(instructions)

        if inst.op == :nop
            instructions_[i] = (op = :jmp, n = inst.n)
        elseif inst.op == :jmp
            instructions_[i] = (op = :nop, n = inst.n)
        end
        exit, acc = run(instructions_)
        exit == complete && return acc
    end
end

println(part1())

println(part2())
