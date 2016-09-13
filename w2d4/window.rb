require_relative 'stackqueue'
require 'benchmark'

#O(n * w)

def windowed_max_range arr, w
  current = 0

  arr.each_cons(w) do |set|
    range = set.max - set.min
    current = range if range > current
  end

  current
end

#O(n)

def windowed_max_range arr, w
  current = 0

  queue = MinMaxStackQueue.new

  w.times do |i|
    queue.enqueue(arr[i])
  end

  range = queue.max - queue.min
  current = range if range > current

  arr[w..-1].each do |el|
    queue.enqueue(el)
    queue.dequeue

    range = queue.max - queue.min
    current = range if range > current
  end

  current
end

%q(
windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
).split("\n").each{|line| eval line}
