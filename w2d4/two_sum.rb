require 'benchmark'
#O(n^2)

def bad_two_sum?(arr, target_sum)
  (0...arr.length).each do |i|
    (i+1...arr.length).each do |j|
      return true if arr[i] + arr[j] == target_sum
    end
  end
  false
end

#O(n lg n if mergesort)

def okay_two_sum?(arr, target_sum)
  arr.sort!

  arr.each_with_index do |el, i|
    sub_arr = arr[0...i] + arr[i+1..-1]
    return true if bsearch(sub_arr, target_sum - el)
  end

  false
end

def bsearch sorted_arr, target
  return nil if sorted_arr.empty?

  mid = sorted_arr.length / 2
  val = sorted_arr[mid]

  if val == target then val
  elsif val < target then bsearch(sorted_arr[0...mid], target)
  else bsearch(sorted_arr[mid + 1..-1], target)
  end
end

#O(n)

def two_sum? arr, target_sum
  # hash = arr.each_with_object(Hash.new(0)){ |el, hash| hash[el] += 1 }
  hash = Hash.new(0)
  arr.each do |el|
    hash[el] += 1
  end

  hash.keys.each do |el|
    hash[el] -= 1
    return true if hash[target_sum - el] > 0
    hash[el] += 1
  end

  false
end

#O(n^i-1)

def i_sum? arr, target_sum, i
  return two_sum?(arr, target_sum) if i == 2

  arr.each_with_index do |el, i|
    new_arr = arr[0...i] + arr[i+1..-1]
    return true if i_sum?(new_arr, target_sum - el, i - 1)
  end

  false
end

Benchmark.bm(7) do |x|
  # arr = (0..2000).to_a
  #
  # x.report('bad_two_sum') { 100.times do bad_two_sum?(arr, rand(4000)) end }
  # x.report('ok_two_sum') { 100.times do okay_two_sum?(arr, rand(4000)) end }
  # x.report('two_sum') { 100.times do two_sum?(arr, rand(4000)) end }

  arr = (0..15).to_a

  x.report('i_sum') { 1.times do i_sum?(arr, 12, 3) end }
end

# arr = [0, 1, 5, 7]
# p two_sum?(arr, 6) # => should be true
# p two_sum?(arr, 10) # => should be false
#
# arr = [0,1,5,7,4]
# p i_sum?(arr, 13, 4)
# p i_sum?(arr, 10, 4)
