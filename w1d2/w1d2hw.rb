def sum_to(n)
	return nil if n < 1
	n == 1 ? n : n + sum_to(n-1)
end

def add_numbers(arr = nil)
	return nil if arr == nil
	arr.length <= 1 ? arr[0] : arr[0] + add_numbers(arr[1..-1])
end

def gamma(n)
	return nil if n < 1
	n == 1 ? 1 : (n-1) * gamma(n - 1)
end
