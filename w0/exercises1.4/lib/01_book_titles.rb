class Book
	attr_accessor :title

	def title= title
		minor_words = ['the', 'a', 'an', 'and', 'in', 'of']
		title = title.split.map do |word|
			minor_words.include?(word) ? word : word.capitalize
		end.join(' ')
		title[0] = title[0].upcase
		@title = title
	end
end
