class Board
	attr_accessor :grid
	def initialize grid = Board.default_grid
		@grid = grid
	end

	def [] position
		i, j = position
		@grid[i][j]
	end

	def []= position, value
		i, j = position
		@grid[i][j] = value
	end

	def display
		print @grid
	end

	def self.default_grid
		Array.new(10){Array.new(10)}
	end

	def count
		@grid.flatten.count(:s)
	end

	def empty? position = nil
		if position == nil then count == 0
		else self[position] != :s end
	end

	def full?
		@grid.flatten.count(nil) == 0
	end

	def place_random_ship
		raise if full?
		initial = count
		@grid[rand(@grid.length), rand(@grid.length)] = :s until count == initial + 1
	end

	def won?
		empty?
	end
end
