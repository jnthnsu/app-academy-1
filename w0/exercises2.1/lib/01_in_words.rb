class Fixnum
	def in_words
		return 'zero' if self == 0

		ones = {1=> 'one',
	    2=> 'two',
		3=> 'three',
		4=> 'four',
		5=> 'five',
		6=> 'six',
		7=> 'seven',
		8=> 'eight',
		9=> 'nine',
		10=> 'ten',
		11=> 'eleven',
		12=> 'twelve',
		13=> 'thirteen',
		14=> 'fourteen',
		15=> 'fifteen',
		16=> 'sixteen',
		17=> 'seventeen',
		18=> 'eighteen',
		19=> 'nineteen'}

		tens = {20=> 'twenty',
		30=> 'thirty',
		40=> 'forty',
		50=> 'fifty',
		60=> 'sixty',
		70=> 'seventy',
		80=> 'eighty',
		90=> 'ninety'}

		units = {1000=> 'thousand',
		1000000=> 'million',
		1000000000=> 'billion',
		1000000000000=> 'trillion'}

		string = ''
		digits = Array.new(15){|i| self/10 ** i % 10}.reverse

		[12, 9, 6, 3].each do |i|
			next if digits[-i-3..-i-1].reduce(:+) == 0
			string << (digits[-i-3] * 100 + digits[-i-2] * 10 + digits[-i-1]).in_words << ' '
			string << units[10 ** i] << ' '
		end if self >= 1000

		string << ones[digits[-3]] << ' hundred ' if digits[-3] != 0
		if digits[-2] >= 2
			string << tens[digits[-2] * 10] << ' '
			string << ones[digits[-1]] << ' ' if digits[-1] != 0
		elsif self % 20 != 0
			string << ones[digits[-2] * 10 + digits[-1]] << ' '
		end
		
		string.chop
	end
end
