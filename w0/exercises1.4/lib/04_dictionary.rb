class Dictionary
	attr_accessor :entries
	def initialize
		@entries = Hash.new
	end

	def add entry
		entry.class == String ? @entries[entry] = nil : @entries.merge!(entry)
	end

	def keywords
		@entries.keys.sort
	end

	def include? word
		keywords.include?(word)
	end

	def find prefix
		@entries.select{|k, v| k[0...prefix.length] == prefix[0...prefix.length]}
	end

	def printable
		@entries.inject([]){|printable, (k, v)| printable << "[#{k}] \"#{v}\"\n"}.sort.join('').chop
	end
end
