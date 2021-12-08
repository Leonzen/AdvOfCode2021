class PreSegment
    attr_accessor :t
    attr_accessor :r
    attr_accessor :lt
    attr_accessor :lb

    def initialize
        @t = ""
        @r = ""
        @lt = ""
        @lb = ""
    end
end

class Segement
    attr_accessor :t
    attr_accessor :tl
    attr_accessor :tr
    attr_accessor :m
    attr_accessor :b
    attr_accessor :bl
    attr_accessor :br

    def initialize
        @t = ""
        @tl = ""
        @tr = ""
        @m = ""
        @b = ""
        @bl = ""
        @br = ""
    end

    def getValue(numbers)
        n = ""
        numbers.each do |number|
            case
                when number.chars.sort.join == (self.t+self.tr+self.br+self.b+self.bl+self.tl).chars.sort.join then n += "0"  # 0
                when number.chars.sort.join == (self.tr+self.br).chars.sort.join then n += "1"  # 1
                when number.chars.sort.join == (self.t+self.tr+self.m+self.bl+self.b).chars.sort.join then n += "2"  # 2
                when number.chars.sort.join == (self.t+self.tr+self.m+self.br+self.b).chars.sort.join then n += "3"  # 3
                when number.chars.sort.join == (self.tl+self.m+self.tr+self.br).chars.sort.join then n += "4"  # 4
                when number.chars.sort.join == (self.t+self.tl+self.m+self.br+self.b).chars.sort.join then n += "5"  # 5
                when number.chars.sort.join == (self.t+self.tl+self.m+self.br+self.b+self.bl).chars.sort.join then n += "6"  # 6
                when number.chars.sort.join == (self.t+self.tr+self.br).chars.sort.join then n += "7"  # 7
                when number.chars.sort.join == (self.t+self.tr+self.tl+self.m+self.bl+self.br+self.b).chars.sort.join then n += "8"  # 8
                when number.chars.sort.join == (self.t+self.tl+self.m+self.tr+self.br+self.b).chars.sort.join then n += "9" # 9
            end
        end
        n
    end
end

def determineUniques(input)
    u = Array.new(4, 0)
    input.each do |i|
        u[0] = i if i.size() == 2 # 1
        u[1] = i if i.size() == 4 # 4
        u[2] = i if i.size() == 3 # 7
        u[3] = i if i.size() == 7 # 8
    end
    u
end

def determinePreSegment(unique)
    ps = PreSegment.new
    ps.t = unique[2].tr(unique[0], "")
    ps.r = unique[0]
    ps.lt = unique[1].tr(unique[0], "")
    ps.lb = unique[3].tr(ps.t+ps.r+ps.lt, "")
    ps
end

fileLines = File.readlines('day8_input.txt')

inputs = []
outputs = []
fileLines.each do |fl|
    inputs.push(fl.split("|")[0].split(" "))
    outputs.push(fl.split("|")[1].split(" "))
end

value = 0
for i in 0..inputs.size()-1 do
    tmp = []
    u = determineUniques(inputs[i])
    ps = determinePreSegment(u)
    s = Segement.new

    s.t = ps.t

    inputs[i].map {|s| tmp.push(s) if s.size() == 5}
    tmp.map {|i| tmp = i.tr(ps.t+ps.lt, "") if i.tr(ps.t+ps.lt, "").size() == 2}
    s.b = tmp.tr(ps.r, "")
    s.br = tmp.tr(s.b, "")
    s.bl = ps.lb.tr(s.b, "")
    s.tr = ps.r.tr(s.br, "")

    tmp = []
    inputs[i].map {|s| tmp.push(s) if s.size() == 5}
    tmp.map {|i| s.m = i.tr(s.t+s.tr+s.bl+s.b, "") if i.tr(s.t+s.tr+s.bl+s.b, "").size() == 1}
    s.tl = u[1].tr(s.tr+s.br+s.m, "")

    value += s.getValue(outputs[i]).to_i
end

puts value