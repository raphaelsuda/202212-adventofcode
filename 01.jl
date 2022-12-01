## PART 1
input = map(split.(split(read("01.input", String), "\n\n"), "\n")) do elf
    sum(parse.(Int, elf))
end

maximum(input)

## PART 2
sum(sort(input)[end-2:end])