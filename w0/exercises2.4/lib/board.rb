class Board
	attr_reader :grid
	def initialize grid = Array.new(3){Array.new(3)}
		@grid = grid
	end

	def [] row, col
		@grid[row][col]
	end

	def []= row, col, mark
		@grid[row][col] = mark
	end

	def place_mark position, mark
		raise if !empty?(position)
		self[*position] = mark
	end

	def empty? position
		self[*position] == nil
	end

	def winner
		threes = @grid + @grid.transpose + [[self[0,0], self[1,1], self[2,2]]] + [[self[0,2], self[1,1], self[2,0]]]
		[:X, :O].each do |mark|
			return mark if threes.include? [mark, mark, mark]
		end
		return nil
	end

	def over?
		return true if !@grid.flatten.include?(nil)
		winner != nil
	end
end
