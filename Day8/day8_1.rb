fileLines = File.readlines('day8_input.txt')
numbers = Array.new(10, 0)

for i in 0..fileLines.size()-1
    tmp = fileLines[i].split("|")[1].split(" ")
    for j in 0..tmp.size()-1
        case
            when tmp[j].size() == 2 then numbers[1] += 1
            when tmp[j].size() == 3 then numbers[7] += 1
            when tmp[j].size() == 4 then numbers[4] += 1
            when tmp[j].size() == 7 then numbers[8] += 1
        end
    end
end

puts numbers.sum