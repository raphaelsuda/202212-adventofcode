signal = read("06.input", String)

find_marker(n, signal) = findfirst(map(i->length(unique(signal[i:i+(n-1)])) == n, 1:length(signal)-(n-1))) + (n-1)

## PART 1
find_marker(4, signal)

## PART 2
find_marker(14, signal)