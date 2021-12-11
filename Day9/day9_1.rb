fileLines = File.readlines('day9_input.txt').map {|l| l.split(//)}
$min = 0
$max = fileLines.size()-1

def getNeighbours(i, j)
    tmp = []
    tmp.push([i-1,j]) if i-1 >= $min
    tmp.push([i+1,j]) if i+1 <= $max
    tmp.push([i,j-1]) if j-1 >= $min
    tmp.push([i,j+1]) if j+1 <= $max
    tmp
end

lowPoints = []
for i in 0..fileLines.size()-1
    for j in 0..fileLines.size()-1
        lowPoint = true
        getNeighbours(i, j).each do |n|
            if fileLines[i][j].to_i >= fileLines[n[0]][n[1]].to_i
                lowPoint = false
                break
            end
        end
        lowPoints.push(fileLines[i][j].to_i) if lowPoint == true
    end
end

puts lowPoints.sum + lowPoints.size