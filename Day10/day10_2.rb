fileLines = File.readlines('day10_input.txt')
openBrackets = "([{<"
closeBrackets = ")]}>"

err = []
correction = []
results = []

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
                    lastOpen = []
                    break
                end
            end
        end
    end
    correction.push(lastOpen) if lastOpen.size > 1
end

for i in 0..correction.size-1 do
    for j in 0..correction[i].size-1 do
        correction[i][j] = closeBrackets[openBrackets.index(correction[i][j])]
    end
    correction[i] = correction[i].reverse
end

correction.each do |brackets|
    tmp = 0
    brackets.each do |b|
        tmp *= 5
        tmp += 1 if b == ")"
        tmp += 2 if b == "]"
        tmp += 3 if b == "}"
        tmp += 4 if b == ">"
    end
    results.push(tmp)
end

puts results.sort[(results.size/2).ceil]