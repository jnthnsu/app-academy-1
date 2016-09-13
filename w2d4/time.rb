require 'benchmark'
def my_min arr
  first = arr.first

  arr.each do |el|
    if el < first
      first = el
    end
  end

  first
end

def sub_sum arr
  sum = []
  arr.each_with_index do |el, i|
    (i..arr.length - 1).each do |j|
      sum << arr[i..j]
    end
  end

  total_sum = []
  sum.each do |sum|
    total_sum << sum.inject(:+)
  end

  total_sum.max
end

def sub_sum arr
  sum = 0
  largest = 0

  arr.each do |el|
    sum += el

    if sum > largest
      largest = sum
    end

    if sum < 0
      sum = 0
    end
  end

  largest
end





list = [2, 3, -6, 7, -1, -2, 7]
p sub_sum2(list)  # =>  -5
