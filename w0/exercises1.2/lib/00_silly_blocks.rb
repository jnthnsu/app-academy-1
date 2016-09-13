def reverser &prc
	prc.call.split.map{|word| word.reverse}.join(' ')
end

def adder a = 1, &prc
	prc.call + a
end

def repeater n = 1, &prc
	n.times{prc.call}
end
