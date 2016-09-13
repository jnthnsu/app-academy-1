def measure n = 1, &prc
	start = Time.now
	n.times{prc.call}
	(Time.now - start) / n
end
