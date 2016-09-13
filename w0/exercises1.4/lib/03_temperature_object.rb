class Temperature
	attr_accessor :temperature
	def initialize temperature
		@temperature = Hash.new.merge(temperature)
		@temperature[:c] = ftoc(@temperature[:f]) if @temperature[:c] == nil
		@temperature[:f] = ctof(@temperature[:c]) if @temperature[:f] == nil
	end

	def in_celsius
		@temperature[:c]
	end

	def in_fahrenheit
		@temperature[:f]
	end

	def self.from_fahrenheit temperature
		Temperature.new(f: temperature)
	end
	def self.from_celsius temperature
		Temperature.new(c: temperature)
	end

	def ftoc temperature
		(temperature - 32.0) * 5 / 9
	end

	def ctof temperature
		9.0 / 5 * temperature + 32
	end
end

class Celsius < Temperature
	def initialize temperature
		@temperature = {c: temperature}
		@temperature[:f] = ctof(@temperature[:c])
	end
end

class Fahrenheit < Temperature
	def initialize temperature
		@temperature = {f: temperature}
		@temperature[:c] = ftoc(@temperature[:f])
	end
end
