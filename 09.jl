function move_knot(primary_knot, secondary_knot, primary_step)
    primary_knot = primary_knot .+ primary_step
    difference = primary_knot .- secondary_knot
    if maximum(abs.(difference)) == 2
        secondary_step = sign.(difference)
        secondary_knot = secondary_knot .+ secondary_step
    else
        secondary_step = (0,0)
    end
    return primary_knot, secondary_knot, secondary_step
end

function move_rope(knots, head_step)
    new_knots = similar(knots)
    primary_step = head_step
    for i in 1:length(knots)-1
        new_knots[i], new_knots[i+1], primary_step = move_knot(knots[i], knots[i+1], primary_step)
    end
    return new_knots
end

direction_coordinates = Dict("R" => (1,0),
            "L" => (-1,0),
            "U" => (0,1),
            "D" => (0,-1))

input = map(split.(readlines("09.input"), ' ')) do line
    return (direction=line[1], multiplier=parse(Int,line[2]))
end

## PART 1
function part_1(input; head=(0,0), tail=(0,0))
    points_visited_by_tail = Set{Tuple}()
    for command in input
        for n in 1:command.multiplier
            head, tail, step = move_knot(head, tail, direction_coordinates[command.direction])
            push!(points_visited_by_tail, tail)
        end
    end
    return length(points_visited_by_tail)
end

part_1(input)

## PART 2
function part_2(input; start=(0,0), rope_length=10)
    points_visited_by_tail = Set{Tuple}()
    knots = [start for i in 1:rope_length]
    for command in input
        for n in 1:command.multiplier
            knots = move_rope(knots, direction_coordinates[command.direction])
            push!(points_visited_by_tail, knots[end])
        end
    end
    return length(points_visited_by_tail)
end

part_2(input)