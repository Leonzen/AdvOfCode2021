class BlockPosition
    attr_accessor :row
    attr_accessor :column

    def initialize(r, c)
        @row = r
        @column = c
    end
end

class BlockNumber
    attr_accessor :value
    attr_accessor :marked
    
    def initialize(number)
        @value = number
        @marked = false
    end
end

class Row
    attr_accessor :blockNumbers
    
    def initialize(numbers)
        @blockNumbers = Array.new(5) {|i| BlockNumber.new(numbers[i])}
    end

    def getWinningRow()
        result = true
        blockNumbers.each do |bn|
            result = false if bn.marked == false
            break if result == false
        end
        result
    end
end

class Block
    attr_accessor :values
    attr_accessor :rows
    attr_accessor :columns

    def initialize(numbers)
        @values = numbers.flatten
        @rows = Array.new(5) {|i| Row.new(numbers[i])}
        @columns = Array.new(5) {|i| Row.new(numbers.transpose[i])}
    end

    def getPosition(number)
        if values.index(number.to_s) != nil
            BlockPosition.new(values.index(number.to_s) / 5, values.index(number.to_s) % 5)
        else
            nil
        end
    end

    def markNumber(number)
        p = self.getPosition(number)
        if p != nil
            self.rows[p.row].blockNumbers[p.column].marked = true
            self.columns[p.column].blockNumbers[p.row].marked = true
        end
    end

    def getWinningState()
        result = false
        self.rows.each do |row|
            result = true if row.getWinningRow() == true
        end
        if result == false 
            self.columns.each do |column|
                result = true if column.getWinningRow() == true
            end
        end
        result
    end

    def sumUmarkedNumbers()
        sum = 0
        self.rows.each do |row|
            row.blockNumbers.each do |bn|
                sum += bn.value.to_i if bn.marked == false 
            end
        end
        sum
    end
end

def getBlockValues(rows)
    Array.new(5) {|i| rows[i].split(" ")}
end


fileLines = File.readlines('blocks.txt')
drawnNumbers = [67,31,58,8,79,18,19,45,38,13,40,62,85,10,21,96,56,55,4,36,76,42,32,34,39,89,6,12,24,57,93,47,41,52,83,61,5,37,28,15,86,23,69,92,70,27,25,53,44,80,65,22,99,43,66,26,11,72,2,98,14,82,87,20,73,46,35,7,1,84,95,74,81,63,78,94,16,60,29,97,91,30,17,54,68,90,71,88,77,9,64,50,0,49,48,75,3,59,51,33]
blocks = []

# generate blocks
j = 0
for i in 0..fileLines.size()/6 do # 6 -> block size = 5 lines + 1 empty line
    blocks.push(Block.new(getBlockValues(fileLines[j..j+4])))
    j += 6 # jump to the next block (block size = 5 lines + 1 empty line)
end

lastNumber = nil
winningBlock = nil
drawnNumbers.each do |number|
    blocks.each do |block|
        block.markNumber(number)
        if block.getWinningState() == true
            winningBlock = block
            lastNumber = number
            break
        end
    end
    break if winningBlock != nil
end

puts lastNumber * winningBlock.sumUmarkedNumbers()