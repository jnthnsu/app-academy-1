# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
	number = rand(100) + 1
	guesses = 0
	loop do
		guesses += 1
		puts 'guess a number'
		guess = gets.chomp.to_i
		if guess > number then puts "#{guess} too high."
		elsif guess < number then puts "#{guess} too low."
		else break end
	end
	puts "#{number}, #{guesses}"
end

def shuffle
	file = gets.chomp
	lines = File.readlines(file)
	lines.shuffle!
	File.open("#{file.chomp(".txt")}-shuffled.txt", 'w') do |f|
		lines.each{|line| f.puts(line)}
	end
end
