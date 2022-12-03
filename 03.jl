rucksacks = map(readlines("03.input")) do line
    l = length(line)
    (all = Set(line), left=Set(line[1:l÷2]), right=Set(line[l÷2+1:end]))
end

letters = [collect('a':'z');collect('A':'Z')]
priority = Dict(letters[i] => i for i in eachindex(letters))

## PART 1
sum(map(x->priority[collect(x.left ∩ x.right)[1]], rucksacks))

## PART 2
badges = [rucksacks[1+(i-1)*3].all ∩ rucksacks[2+(i-1)*3].all ∩ rucksacks[3+(i-1)*3].all for i in 1:length(rucksacks)÷3]
sum(map(x->priority[collect(x)[1]], badges))