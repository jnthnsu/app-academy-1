def add a, b
	a + b
end

def subtract a, b
	a - b
end

def sum array
	array.reduce(0, :+)
end

def multiply a, *b
	[a, *b].reduce(1, :*)
end

def power a, b
	a ** b
end

def factorial n
	(1..n).reduce(:*) || 1
end
