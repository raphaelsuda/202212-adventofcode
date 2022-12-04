parse_assignment(a) = range(parse.(Int, split(a, '-'))...)

assignments = map(readlines("04.input")) do l
    Set.(parse_assignment.(split(l, ',')))
end

## PART 1
count(map(x->maximum(length.(x))==length(∪(x...)), assignments))

## PART 2
count(map(x->length(∩(x...))!=0, assignments))