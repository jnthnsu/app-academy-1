class Code
	PEGS = Hash[['R', 'G', 'B', 'Y', 'O', 'P'].zip([0] * 6)]
	@@colors = PEGS.keys

	attr_reader :pegs
	def initialize pegs
		@pegs = pegs
  	end

	def self.parse string
		raise if string.upcase.chars.any?{|c| !@@colors.include?(c)}
		Code.new(string.upcase.chars)
	end

	def self.random
		Code.new(Array.new(4){@@colors[rand(6)]})
	end

	def [] i
		@pegs[i]
	end

	def == code
		@pegs == code.pegs rescue false
	end

	def exact_matches code
		@pegs.select.with_index{|color, i| color == code.pegs[i]}.length
	end

	def near_matches code
		count = 0
		@@colors.each do |color|
			if code.pegs.count(color) >= @pegs.count(color)
				count += @pegs.count(color)
			else
				count += code.pegs.count(color)
			end
		end
		count - exact_matches(code)
	end
end

class Game
	attr_reader :secret_code
	def initialize secret_code = Code.random
		@secret_code = secret_code
	end

	def get_guess
		puts 'guess!'
		code = gets.chomp
		Code.parse(code)
	end

	def display_matches code
		puts 'exact:' + @secret_code.exact_matches(code).to_s
		puts 'near:' + @secret_code.near_matches(code).to_s
	end

	def run
		10.times do
			guess = get_guess
			if guess == @secret_code
				puts 'You win!'
				return
			end
			display_matches guess
		end
		puts 'You lose.'
	end
end
