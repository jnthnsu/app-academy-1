class RPNCalculator
	attr_accessor :stack
	def initialize
		@stack = []
	end
	def push x
		@stack.push(x.to_f) rescue @stack.push(x)
	end
	def run
		begin
			@stack[-3] = @stack[-3..-2].reduce(stack[-1])
			@stack.pop(2)
		rescue
			raise "calculator is empty"
		end
	end
	def plus
		push(:+)
		run
	end
	def minus
		push(:-)
		run
	end
	def times
		push(:*)
		run
	end
	def divide
		push(:/)
		run
	end
	def value
		@stack[-1]
	end
	def tokens tokens
		tokens.split.map{|token| '+-*/'.include?(token) ? token.to_sym : token.to_i}
	end
	def evaluate string
		calc = RPNCalculator.new
		tokens = tokens(string)
		until tokens.empty?
			calc.push(tokens.shift) until calc.stack[-1].class == Symbol
			calc.run
		end
		calc.value
	end
end
