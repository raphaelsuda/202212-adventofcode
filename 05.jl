input = split(read("05.input", String), "\n\n")

crate_input = split(input[1], "\n")[1:end-1]
instructions = map(split(input[2], "\n")) do inst
    x = parse.(Int, split(inst, " ")[2:2:6])
    (n=x[1], from=x[2], to=x[3])
end


function get_stack(input, pos)
    i = 2 + (pos-1) * 4
    stack = Char[]
    for l in input
        if l[i] != ' '
            push!(stack, l[i])
        end
    end
    return stack
end

function get_stacks(input)
    n = (length(input[1]) + 1) ÷ 4
    return [get_stack(input, i) for i in 1:n]
end

function move_crate!(from, to, stacks; n=1)
    moved_crates = Char[]
    for i in 1:n
        insert!(moved_crates, 1, popfirst!(stacks[from]))
    end
    for c in moved_crates
        insert!(stacks[to], 1, c)
    end
    return stacks
end

## PART 1
stacks = get_stacks(crate_input)
for i in instructions
    for j in 1:i.n
        move_crate!(i.from, i.to, stacks)
    end
end
join([stacks[i][1] for i in eachindex(stacks)])

## PART 2
stacks = get_stacks(crate_input)
for i in instructions
    move_crate!(i.from, i.to, stacks; n=i.n)
end
join([stacks[i][1] for i in eachindex(stacks)])