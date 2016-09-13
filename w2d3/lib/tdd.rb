class Array
  def my_uniq
    result = []
    self.each  do |el|
        result << el  unless result.include? el
    end
  # self.reject {|x| x == nil }
  result
  end

  def two_sum
      result =[]
      self.each.with_index do |el,i|
        self.each.with_index do |el2,j|
            result << [i,j] if (self[i]+ self[j]) == 0  && (i < j )
        end
      end
        result
  end

  def my_transpose
      self.map.with_index do |row,i|
        row.map.with_index do |col,j|
            self[j][i]
        end
      end
  end

  def stock_prices
      max = [0, 0]

      i = 0
      while i < self.length - 1
            j = i + 1
            while j < self.length
              if self[i] - self[j] < self[max[0]] - self[max[1]]
                max = [i, j]
              end
              j += 1
            end
      i += 1
    end
    max
  end
end

class Towers
  attr_reader :towers
  def initialize
    @towers = [[3, 2, 1], [], []]
  end

  def prompt
    gets.chomp.split(',').map(&:to_i)
  end

  def move
    input = prompt
    x, y = input

    @towers[y].push(@towers[x].pop)
    p @towers
  end

  def won?
    @towers[1] == [3,2,1] || @towers.last == [3,2,1]
  end

  def run
    until won?
      move
    end
  end
end

# self[i+1..-1].each.with_index do |el2, j|
#     if self[i] == self[j]
#        self[j] = nil
#     end
#   end
