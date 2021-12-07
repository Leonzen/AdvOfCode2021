fileLines = File.readlines('day7_input.txt')[0].split(",").map { |s| s.to_i }
fuels = Array.new(fileLines.max, 0)

fileLines.each do |f|
    for i in 0..fuels.size-1
        fuels[i] += (f-(i+1)).abs
    end
end

puts fuels.min