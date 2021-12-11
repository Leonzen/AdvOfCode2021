fileLines = File.readlines('day10_input.txt')
openBrackets = "([{<"
closeBrackets = ")]}>"



err = []
fileLines.each do |fl|
    lastOpen = []
    for i in 0..fl.size-1 do
        lastOpen.push(fl[i]) if fl[i].count(openBrackets) == 1
        if fl[i+1].nil? == false
            next if fl[i+1].count(openBrackets) == 1
            if fl[i+1].count(closeBrackets) == 1
                if openBrackets.index(lastOpen.last) == closeBrackets.index(fl[i+1])
                    lastOpen.pop
                    next
                end
                if openBrackets.index(lastOpen.last) != closeBrackets.index(fl[i+1])
                    err.push(fl[i+1])
                    break
                end
            end
        end
    end
end

puts (err.count ")") * 3 + (err.count "]") * 57 + (err.count "}") * 1197 + (err.count ">") * 25137
