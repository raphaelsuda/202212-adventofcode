input = split(read("05.input", String), "\n\n")

crate_input = split(input[1], "\n")[1:end-1]
instructions = map(split(input[2], "\n")) do inst
    x = parse.(Int, split(inst, " ")[2:2:6])
    (n=x[1], from=x[2], to=x[3])
end


function get_stack(input, pos)
    i = 2 + (pos-1) * 4
    stack = Dict{Int, Char}()
    counter = 1
    for l in input
        if l[i] == ' '
            continue
        end
        stack[counter] = l[i]
        counter += 1
    end
    return stack
end

function get_stacks(input)
    n = (length(input[1]) + 1) ÷ 4
    return Dict(i => get_stack(input, i) for i in 1:n)
end

function move_crate!(from, to, stacks; n=1)
    for i in length(stacks[to]):-1:1
        stacks[to][i+n] = stacks[to][i]
    end
    for i in 1:n
        stacks[to][i] = stacks[from][i]
    end
    for i in n+1:length(stacks[from])
        stacks[from][i-n] = stacks[from][i]
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
message = ""
for i in 1:length(stacks)
    message *= stacks[i][1]
end
message

## PART 2
stacks = get_stacks(crate_input)
for i in instructions
    move_crate!(i.from, i.to, stacks; n=i.n)
end
message = ""
for i in 1:length(stacks)
    message *= stacks[i][1]
end
message