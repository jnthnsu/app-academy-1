#no q without qu
#if qu, qu is last consonant in initial consonants
def translate sentence
	words = sentence.split
	words.map! do |word|
		if 'aeiou'[word[0]] then word + 'ay'
		else word.sub(/qu|[^aeioqu]+(qu)*/, '') + word.slice(/qu|[^aeioqu]+(qu)*/) + 'ay' end
	end
	words.join(' ')
end
