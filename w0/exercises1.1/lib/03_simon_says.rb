def echo word
	word
end

def shout word
	word.upcase
end

def repeat word, times = 2
	(" #{word}" * times)[1..-1]
end

def start_of_word word, letters = 1
	word[0...letters]
end

def first_word title
	title.split[0]
end

def titleize title
	title_words = title.split
	little_words = ['and', 'the', 'over']
	title_words.map!{|word| little_words.include?(word) ? word : word.capitalize}
	title_words[0].capitalize!
	title_words.join(' ')
end
