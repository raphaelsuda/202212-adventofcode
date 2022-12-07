input = readlines("07.input")


function explore(line, working_directory, files)
    l = split(line, ' ')
    if l[1] == "\$"
        if l[2] == "cd"
            if l[3] == "/"
                working_directory = "/"
            elseif l[3] == ".."
                total_size = sum([f.size for f in values(files[working_directory])])
                last_dir_name = split(working_directory, '/')[end-1]
                working_directory = join(split(working_directory, '/')[1:end-2], '/')*"/"
                files[working_directory][last_dir_name] = (type="dir", size=total_size)
            else
                working_directory *= l[3] * "/"
            end
        elseif l[2] == "ls"
            files[working_directory] = Dict{AbstractString, NamedTuple}()
            return working_directory, files
        end
    elseif l[1] == "dir"
        files[working_directory][l[2]] = (type="dir", size=0)
    else
        file_size = parse(Int, l[1])
        files[working_directory][l[2]] = (type="file", size=file_size)
    end
    return working_directory, files
end

files = Dict{AbstractString, Dict}()
working_directory = ""
for l in input
    working_directory, files = explore(l, working_directory, files)
end
working_directory, files = explore("\$ cd ..", working_directory, files)

## PART 1
part_1 = 0
for dir in values(files)
    for f in values(dir)
        if f.type == "dir" && f.size < 100000
            part_1 += f.size
        end
    end
end 
println(part_1)

## PART 2
disk_size = 70000000
space_needed = 30000000
part_2 = space_needed
total_file_size = reduce(+, f.size for f in values(files["/"]))
free_space = disk_size - total_file_size
for dir in values(files)
    for f in values(dir)
        if f.type == "dir" && f.size > (space_needed - free_space)
            part_2 = min(part_2, f.size)
        end
    end
end
println(part_2)
            