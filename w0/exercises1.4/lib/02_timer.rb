class Timer
	attr_accessor :seconds

	def initialize
		@seconds = 0
	end

	def time_string
		time = ''
		3.times do |i|
			unit = (@seconds/60 ** (2 - i) % 60).to_s + ':'
			unit = '0' + unit until unit.length == 3
			time << unit
		end
		time[0...-1]
	end
end
