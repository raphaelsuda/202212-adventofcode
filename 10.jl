function execute(command, register)
    if command == "noop"
        return [register]
    else
        return [register;register + parse(Int, split(command, ' ')[end])]
    end
end

input = readlines("10.input")

## PART 1
function part_1(input)
    signal_strength = [1]
    for command in input
        append!(signal_strength, execute(command, signal_strength[end]))
    end
    positions = collect(20:40:220)
    return sum(signal_strength[positions].*positions)
end

part_1(input)

## PART 2
function print_pixel(cycle, value; display_width=40)
    horizontal_position = mod1(cycle, display_width) - 1
    if horizontal_position in [value+i for i in -1:1]
        pixel = '#'
    else
        pixel = '.'
    end
    horizontal_position == (display_width - 1) ? println(pixel) : print(pixel)
end

function part_2(input)
    signal_strength = [1]
    for command in input
        append!(signal_strength, execute(command, signal_strength[end]))
    end
    for (cycle, value) in enumerate(signal_strength)
        print_pixel(cycle, value)
    end
end

part_2(input)