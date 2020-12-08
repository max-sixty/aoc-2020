
str = (read(open("Day-08.txt"), String) |> strip |> x -> split(x, "\n"))

instructions = map(str) do x
    op, num = split(x, " ")
    (; op, n = parse(Int, num))
end

function run1()
    ptr = 1
    acc = 0
    history = []
    while true
        current = instructions[ptr]
        if ptr in history
            return acc
        end
        push!(history, ptr)
        if current.op == "nop"
            ptr += 1
        elseif current.op == "acc"
            acc += current.n
            ptr += 1
        elseif current.op == "jmp"
            ptr += current.n
        end
    end
end

println(run1())

function run2(instructions)
    ptr = 1
    acc = 0
    history = []
    while true
        if ptr == length(instructions) + 1
            return acc
        end
        current = instructions[ptr]
        if ptr in history
            return nothing
        end
        push!(history, ptr)
        if current.op == "nop"
            ptr += 1
        elseif current.op == "acc"
            acc += current.n
            ptr += 1
        elseif current.op == "jmp"
            ptr += current.n
        end
    end
end

function find2()
    for i = 1:length(instructions)
        inst = instructions[i]
        instructions_ = copy(instructions)

        if inst.op == "nop"
            instructions_[i] = (; op = "jmp", n = inst.n)
        elseif inst.op == "jmp"
            instructions_[i] = (; op = "nop", n = inst.n)
        end
        result = run2(instructions_)
        if !isnothing(result)
            return result
        end
    end
end

println(find2())
