class Lanternfish
    attr_accessor :timer

    def initialize(t)
        @timer = t
    end

    def spawnChild(fishes)
        if self.timer == 0
            self.timer = 6
            fishes.push(Lanternfish.new(8))
        else
            self.timer -= 1
        end
    end
end

def initFishes(data, fishes) 
    data.each do |d|
        fishes.push(Lanternfish.new(d))
    end
end

initialFishes = [1,3,3,4,5,1,1,1,1,1,1,2,1,4,1,1,1,5,2,2,4,3,1,1,2,5,4,2,2,3,1,2,3,2,1,1,4,4,2,4,4,1,2,4,3,3,3,1,1,3,4,5,2,5,1,2,5,1,1,1,3,2,3,3,1,4,1,1,4,1,4,1,1,1,1,5,4,2,1,2,2,5,5,1,1,1,1,2,1,1,1,1,3,2,3,1,4,3,1,1,3,1,1,1,1,3,3,4,5,1,1,5,4,4,4,4,2,5,1,1,2,5,1,3,4,4,1,4,1,5,5,2,4,5,1,1,3,1,3,1,4,1,3,1,2,2,1,5,1,5,1,3,1,3,1,4,1,4,5,1,4,5,1,1,5,2,2,4,5,1,3,2,4,2,1,1,1,2,1,2,1,3,4,4,2,2,4,2,1,4,1,3,1,3,5,3,1,1,2,2,1,5,2,1,1,1,1,1,5,4,3,5,3,3,1,5,5,4,4,2,1,1,1,2,5,3,3,2,1,1,1,5,5,3,1,4,4,2,4,2,1,1,1,5,1,2,4,1,3,4,4,2,1,4,2,1,3,4,3,3,2,3,1,5,3,1,1,5,1,2,2,4,4,1,2,3,1,2,1,1,2,1,1,1,2,3,5,5,1,2,3,1,3,5,4,2,1,3,3,4]
fishes = []
newFishes = []

initFishes(initialFishes, fishes)

for i in 0..79 do 
    fishes.each do |f|
        f.spawnChild(newFishes)
    end
    if newFishes.size() >= 1
        fishes += newFishes
        newFishes = []
    end
end

puts fishes.size()