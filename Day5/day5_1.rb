class Coordinate
    attr_accessor :x
    attr_accessor :y

    def initialize(x, y)
        @x = x
        @y = y
    end
end

class HeatSpot
    attr_accessor :from
    attr_accessor :to
    attr_accessor :direction
    attr_accessor :steps

    def initialize(f, t)
        @from = Coordinate.new(f[0].to_i, f[1].to_i)
        @to = Coordinate.new(t[0].to_i, t[1].to_i)
        @direction = ""
        @steps = 0
    end

    def determineDirection()
        c = Coordinate.new(self.from.x - self.to.x, self.from.y - self.to.y)
        case
            when c.x != 0 && c.y != 0 then self.direction = "diag"
            when c.x > 0 then self.direction = "l" ; self.steps = c.x.abs
            when c.x < 0 then self.direction = "r" ; self.steps = c.x.abs
            when c.y > 0 then self.direction = "d" ; self.steps = c.y.abs
            when c.y < 0 then self.direction = "u" ; self.steps = c.y.abs
        end
    end
end

def buildMap(heatSpots)
    x = 0
    y = 0
    heatSpots.each do |hs|
        x = hs.from.x if hs.from.x > x
        x = hs.to.x if hs.to.x > x
        y = hs.from.y if hs.from.y > y
        y = hs.to.y if hs.to.y > y
    end
    Array.new(x+1) {Array.new(y+1, 0)}
end

def markSpots(heatSpot, map)
    map[heatSpot.from.x][heatSpot.from.y] += 1 if heatSpot.direction != "diag"
    for i in 1..heatSpot.steps do
        case
            when heatSpot.direction == "u" then map[heatSpot.from.x][heatSpot.from.y + i] += 1
            when heatSpot.direction == "d" then map[heatSpot.from.x][heatSpot.from.y - i] += 1
            when heatSpot.direction == "r" then map[heatSpot.from.x + i][heatSpot.from.y] += 1
            when heatSpot.direction == "l" then map[heatSpot.from.x - i][heatSpot.from.y] += 1
            when heatSpot.direction == "diag" then break
        end
    end
end

fileLines = File.readlines('day5_input.txt')
heatSpots = []
map = nil

fileLines.each do |f|
    heatSpots.push(HeatSpot.new(f.split[0].split(","), f.split[2].split(",")))
end

map = buildMap(heatSpots)

heatSpots.each do |hs|
    hs.determineDirection()
    markSpots(hs, map)
end

cnt = 0
for i in 0..map.size()-1 do
    for j in 0..map[i].size()-1 do
        cnt += 1 if map[i][j].to_i > 1
    end 
end
puts cnt