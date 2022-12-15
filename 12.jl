function read_input(input)
    height_map = permutedims(reduce(hcat,collect.(readlines(input))))
    index_start = findfirst(x -> x == 'S', height_map)
    height_map[index_start] = 'a'
    index_goal = findfirst(x -> x == 'E', height_map)
    height_map[index_goal] = 'z'
    return height_map, index_start, index_goal
end

function is_point_within_map(index, height_map)
    return minimum(index.I) > 0 && index.I[1] <= size(height_map, 1) && index.I[2] <= size(height_map, 2)
end

const DIRECTIONS = [CartesianIndex(1,0);
                    CartesianIndex(0,1);
                    CartesianIndex(-1,0);
                    CartesianIndex(0,-1)]

function get_candidates(index, value, height_map)
    candidates = Dict{CartesianIndex, Int64}()
    for direction in DIRECTIONS
        point = index + direction 
        if !is_point_within_map(point, height_map)
            continue
        end
        if height_map[point] <= height_map[index]+1
            candidates[point] = value + 1
        end
    end
    return candidates
end


## PART 1
function part_1(height_map, index_start, index_goal)
    candidates = Dict{CartesianIndex, Int64}()
    dumped = CartesianIndex[]
    current_index = index_start
    current_value = 0
    counter = 1
    while current_index != index_goal
        new_candidates = get_candidates(current_index, current_value, height_map)
        for (point, value) in new_candidates
            if point in dumped || point in keys(candidates)
                delete!(new_candidates, point)
                continue
            end
            candidates[point] = value
        end
        push!(dumped, current_index)
        if isempty(candidates)
            return length(height_map)
        end
        smallest_value = minimum(values(candidates))
        best_choices = Dict(x => candidates[x] for x in keys(candidates) if candidates[x] == smallest_value)
        current_index = rand(collect(keys(best_choices)))
        current_value = candidates[current_index]
        delete!(candidates, current_index)
    end
    return current_value
end

height_map, index_start, index_goal = read_input("12.input")
part_1(height_map, index_start, index_goal)

## PART 2
function part_2(height_map, index_goal)
    shortest_path = length(height_map)
    for index_start in findall(x -> x == 'a', height_map)
        shortest_path = min(shortest_path, part_1(height_map, index_start, index_goal))
    end
    return shortest_path
end

part_2(height_map, index_goal)