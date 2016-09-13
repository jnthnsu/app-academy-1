class ComputerPlayer
	attr_accessor :name, :mark, :board
	def initialize name
		@name = name
	end

	def display board
		@board = board
	end

	def get_move
		3.times do |i|
			3.times do |j|
				test_board = Board.new(@board.grid.inject([]){|new, i| new << i.dup})
				test_board.place_mark [i,j], @mark if test_board.empty? [i, j]
				return [i, j] if test_board.winner == @mark
			end
		end

		loop do
			i, j = rand(2), rand(2)
			return [i, j] if @board.empty? [i, j]
		end
	end
end
