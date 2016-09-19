require 'byebug'
def range start_idx, end_idx
  return [start_idx] if end_idx <= 0
  range(start_idx, end_idx - 1) + [end_idx]
end

def sum_iter(arr)
  arr.inject(:+)
end

def sum_rec(arr)
  return arr[0] if arr.length == 1

  sum_recursive(arr[0..-2]) + arr[-1]
end

def exp1(b, n)
  return 1 if n == 0

  exp1(b, n - 1) * b
end

def exp2(b, n)
  return 1 if n == 0

  root = exp2(b, n / 2)

  if n.even?
    root * root
  else
    root * root * b
  end
end

class Array
  def deep_dup
    new_arr = []
    self.each do |el|
      if el.is_a?(Array)
        new_arr << el.deep_dup
      elsif !el.is_a?(Numeric)
        new_arr << el.dup
      else
        new_arr << el
      end
    end

    new_arr
  end
end

def fib_iter n
  return [1] if n == 1

  new_arr = [1, 1]

  until new_arr.length == n
    new_arr << new_arr[-2] + new_arr[-1]
  end

  new_arr
end

def fib_rec n
  return [1] if n == 1
  return [1, 1] if n == 2

  prev = fib_rec(n - 1)
  prev << prev[-2] + prev[-1]
end


def bsearch(arr, value)
  return nil if arr == []

  mid_idx = arr.length / 2
  mid_val = arr[mid_idx]

  if value == mid_val
    mid_idx
  elsif value < mid_val
    bsearch(arr[0...mid_idx], value)
  else
    #val is in larger_value subarray, so add that to mid_idx and add 1
    sub_idx = bsearch(arr[mid_idx + 1..-1], value)

    if sub_idx.nil?
      nil
    else
      mid_idx + sub_idx + 1
    end
  end
end

def merge_sort arr
  return arr if arr.length <= 1

  mid_idx = arr.length / 2
  merge(merge_sort(arr[0...mid_idx]), merge_sort(arr[mid_idx..-1]))
end

def merge arr1, arr2
  merged_arr = []
  until arr1.empty? || arr2.empty?
    if arr1.first <= arr2.first
      merged_arr.push(arr1.shift)
    else
      merged_arr.push(arr2.shift)
    end
  end

  if arr1.length > 0
    merged_arr += arr1
  else
    merged_arr += arr2
  end

  merged_arr
end

def subsets arr
  return [[]] if arr.empty?

  prev = subsets(arr[0..-2])

  subs = prev.deep_dup
  prev.each do |el|
    subs << el.push(arr.last)
  end

  subs
end

def greedy_make_change(num, coins)
  return [] if num == 0

  sorted_coins = coins.sort.reverse
  current_coin = sorted_coins.first

  change = [current_coin] * (num / current_coin)
  change += greedy_make_change(num % current_coin, sorted_coins[1..-1])
end

def make_better_change(num, coins)
  return [] if num.zero?

  changes = []
  coins.each do |coin|
    next if coin > num
    changes << [coin] + make_better_change(num - coin, coins)
  end

  changes.min_by(&:length)
end
