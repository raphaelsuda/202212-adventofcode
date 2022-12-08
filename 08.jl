trees = parse.(Int, reduce(hcat, split.(readlines("08.input"), "")))'

## PART 1
function isvisible(i, trees)
    y, x = i.I
    height = trees[i]
    if x ∈ (1, size(trees,2)) || y ∈ (1, size(trees, 1))
        return true
    end
    views = [trees[y, x-1:-1:1],
             trees[y, x+1:end],
             trees[y-1:-1:1, x],
             trees[y+1:end, x]]
    for v in views
        if height > maximum(v)
            return true
        end
    end
    return false
end

part_1 = falses(size(trees))
for i in eachindex(trees)
    part_1[i] = isvisible(i, trees)
end

println(count(part_1))

## PART 2
function scenic_score(i, trees)
    y, x = i.I
    if x ∈ (1, size(trees,2)) || y ∈ (1, size(trees, 1))
        return 0
    end
    height = trees[i]
    scores = zeros(4) 
    views = [trees[y, x-1:-1:1],
             trees[y, x+1:end],
             trees[y-1:-1:1, x],
             trees[y+1:end, x]]
    for (i, v) in enumerate(views)
        for (j, h) in enumerate(v)
            scores[i] = j
            if h >= height
                break
            end
        end
    end
    return Int(prod(scores))
end

part_2 = similar(trees)
for i in eachindex(trees)
    part_2[i] = scenic_score(i, trees)
end

println(maximum(part_2))