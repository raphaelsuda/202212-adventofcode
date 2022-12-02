strategy_guide = Tuple.(split.(readlines("02.input"), " "))

## PART 1
points_per_symbol = Dict("X" => 1,"Y" => 2, "Z" => 3)
points_per_round = Dict("A" => Dict("X" => 3, "Y" => 6, "Z" => 0),
                        "B" => Dict("X" => 0, "Y" => 3, "Z" => 6),
                        "C" => Dict("X" => 6, "Y" => 0, "Z" => 3))

points = map(strategy_guide) do s
    points_per_symbol[s[2]] + points_per_round[s[1]][s[2]]
end
sum(points)

## PART 2
points_per_round = Dict("X" => 0,"Y" => 3, "Z" => 6)
points_per_symbol = Dict("A" => Dict("X" => 3, "Y" => 1, "Z" => 2),
                         "B" => Dict("X" => 1, "Y" => 2, "Z" => 3),
                         "C" => Dict("X" => 2, "Y" => 3, "Z" => 1))

points = map(strategy_guide) do s
    points_per_round[s[2]] + points_per_symbol[s[1]][s[2]]
end
sum(points)