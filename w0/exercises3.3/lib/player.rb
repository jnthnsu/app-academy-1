class HumanPlayer
	def get_play
		puts 'guess x, y? '
		gets.chomp.split(',').map(&:to_i)
	end
end
