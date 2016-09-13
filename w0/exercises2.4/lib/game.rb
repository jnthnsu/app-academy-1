require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
	attr_accessor :player1, :player2, :current_player, :board
	def initialize player1, player2
		@player1 = player1
		@player2 = player2
		@player1.mark = :X
		@player2.mark = :O
		@current_player = @player1
		@board = Board.new
	end

	def switch_players!
		@current_player = @current_player == @player1 ? @player2 : @player1
	end

	def play_turn
		@board.place_mark @current_player.get_move, @current_player.mark
		@player1.display(board)
		@player2.display(board)
		switch_players!
	end

	def play
		loop do
			play_turn
			break if @board.over?
		end
		print @board.winner
	end
end
