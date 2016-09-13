class XmlDocument
	attr_accessor :indent
	def initialize indent = false
		@indent = indent
		@indents = 0
	end

	def method_missing method_name, add= {}, &prc
		method_name = "#{method_name.to_s}"
		method_name += " #{add.to_s[2..-2].delete('>')}" if !add.empty?
		if @indent
			if prc.nil?
				"<#{method_name}/>\n"
			else
				@indents += 1
				indents = @indents
				"<#{method_name}>\n" + '  ' * indents + "#{prc.call}" + '  ' * (indents - 1) + "</#{method_name}>\n"
			end
		else
			prc.nil? ? "<#{method_name}/>" : "<#{method_name}>#{prc.call}</#{method_name}>"
		end
	end
end
