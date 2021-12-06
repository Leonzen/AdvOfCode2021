# solution by https://www.reddit.com/r/adventofcode/comments/r9z49j/2021_day_6_solutions/hniccc4/?utm_source=share&utm_medium=web2x&context=3

fileLines = File.readlines('day6_input.txt')

fishCount = [0, (fileLines[0].count "1"), (fileLines[0].count "2"), (fileLines[0].count "3"), (fileLines[0].count "4"), (fileLines[0].count "5"), 0, 0, 0]

for i in 0..255 do 
    fishToSpawn = fishCount[0];
    fishCount[0] = fishCount[1];
    fishCount[1] = fishCount[2];
    fishCount[2] = fishCount[3];
    fishCount[3] = fishCount[4];
    fishCount[4] = fishCount[5];
    fishCount[5] = fishCount[6];
    fishCount[6] = fishCount[7] + fishToSpawn;
    fishCount[7] = fishCount[8];
    fishCount[8] = fishToSpawn;
end

puts fishCount.sum
