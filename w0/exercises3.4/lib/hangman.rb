class Hangman
  attr_reader :guesser, :referee, :board
  def initialize players
	  @guesser = players[:guesser]
	  @referee = players[:referee]
	  @board = nil
  end

  def setup
	  length = @referee.pick_secret_word
	  @guesser.register_secret_length length
	  @board = Array.new(length)
  end

  def take_turn
	  guess = @guesser.guess
	  indices = @referee.check_guess guess
	  update_board guess, indices
	  guesser.handle_response guess, indices
  end

  def update_board guess, indices
	  indices.each{|i| @board[i] = guess}
  end
end

class Player
	attr_accessor :dictionary
	def initialize dictionary
		@dictionary = dictionary
		
		@secret_length = nil
		@board = nil
		@wrong_board = nil
	end

	def pick_secret_word
		@secret_word = dictionary[rand(dictionary.length)]
		@secret_word.length
	end

	def check_guess guess
		@secret_word.chars.each_with_index.inject([]) do |list, (c, i)|
			list << i if c == guess
			list
		end
	end

	def register_secret_length length
		@secret_length = length
		@board = Array.new(length)
		@wrong_board = Array.new(length){[]}
	end

	def update_board guess, indices
   		indices.each{|i| @board[i] = guess}
     end

	def update_wrong_board guess, indices
   		((0..@secret_length - 1).to_a - indices).each{|i| @wrong_board[i] << guess}
     end

	def handle_response guess, indices
		update_board guess, indices
		update_wrong_board guess, indices
	end

	def guess board = @board
		all_letters = candidate_words(board).join
		counts = Hash.new
		('a'..'z').each{|letter| counts[letter] = all_letters.count(letter)}
		counts.select!{|letter, count| !board.include?(letter)}
		counts.max_by{|letter, count| count}[0]
	end

	def candidate_words board = @board, wrong_board = @wrong_board
		return @dictionary if @secret_length == nil
		set = @dictionary.select{|word| word.length == @secret_length}
		set.select do |word|
			board.each_with_index.all? do |letter, i|
				letter == nil ? true : word[i] == letter
			end &&
			wrong_board.each_with_index.all? do |wrong_letters, i|
				wrong_letters == nil ? true : !wrong_letters.include?(word[i])
			end
		end
	end
end

class HumanPlayer < Player
end

class ComputerPlayer < Player
end
