mutable struct Monkey
    items::Array{Int64}
    op::Function
    divisor::Int64
    test::Function
    throw_to_if_true::Int64
    throw_to_if_false::Int64
    n_inspected::Int64

    function Monkey(input_lines)
        items = parse.(Int, [match.match for match in eachmatch(r"(\d\d)", input_lines[2])])
        op = eval(Meta.parse("old -> $(split(input_lines[3], "= ")[end])"))
        divisor = parse(Int, split(input_lines[4], ' ')[end])
        test = eval(Meta.parse("x -> x%$(divisor) == 0"))
        throw_to_if_true = parse(Int, split(input_lines[5], " ")[end])
        throw_to_if_false = parse(Int, split(input_lines[6], " ")[end])
        n_inspected = 0
        return new(items, op, divisor, test, throw_to_if_true, throw_to_if_false, n_inspected)
    end
end

function juggle!(monkeys; part=1)
    multiplied_divisor = reduce(*, monkey.divisor for monkey in values(monkeys))
    for i in sort(collect(keys(monkeys)))
        monkey = monkeys[i]
        monkey.items = monkey.op.(monkey.items)
        if part == 1
            monkey.items = Int.(floor.(monkey.items./3))
        elseif part == 2
            monkey.items = mod.(monkey.items, multiplied_divisor)
        end
        for item in monkey.items
            monkey.test(item) ? push!(monkeys[monkey.throw_to_if_true].items, item) : push!(monkeys[monkey.throw_to_if_false].items, item)
        end
        monkey.n_inspected += length(monkey.items)
        monkey.items = Int[]
    end
    return monkeys
end

input = split.(split(read("11.input", String), "\n\n"), '\n')

## PART 1
function part_1(monkeys; rounds=20)
    for i in 1:rounds
        juggle!(monkeys; part=1)
    end
    interactions = map(monkey -> monkey.n_inspected, values(monkeys))
    @show interactions
    return prod(sort(interactions)[end-1:end])
end

monkeys = Dict(i-1 => Monkey(input[i]) for i in eachindex(input))
part_1(monkeys)

## PART 2
function part_2(monkeys; rounds=20)
    for i in 1:rounds
        juggle!(monkeys; part=2)
    end
    interactions = map(monkey -> monkey.n_inspected, values(monkeys))
    @show interactions
    return prod(sort(interactions)[end-1:end])
end

monkeys = Dict(i-1 => Monkey(input[i]) for i in eachindex(input))
part_2(monkeys; rounds=10000)