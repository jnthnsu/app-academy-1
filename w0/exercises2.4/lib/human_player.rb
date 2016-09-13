class HumanPlayer
	attr_accessor :name, :mark
	def initialize name
		@name = name
	end

	def display board
		print board.grid
	end

	def get_move
		puts 'where? '
		gets.chomp.split(',').map(&:to_i)
	end
end
