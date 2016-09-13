class MyQueue
  def initialize
    @store = []
  end

  def enqueue el
    @store.push el
  end

  def dequeue
    @store.shift
  end

  def peek
    @store[0]
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

class MyStack
  attr_reader :store

  def initialize
    @store = []
  end

  def max
    @store.empty? ? nil : @store[-1][2]
  end

  def min
    @store.empty? ? nil : @store[-1][1]
  end

  def push el
    @max = el if empty? || el > @max
    @min = el if empty? || el < @min

    if @store.empty?
      @store << [el, el, el]
    else
      @store << [el, @min, @max]
    end

    el
  end

  def pop
    el = @store.pop
    if empty?
      @min, @max = nil, nil
    else
      _, @min, @max = @store.last
    end

    el
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

class MinMaxStackQueue
  def initialize
    @store1 = MyStack.new
    @store2 = MyStack.new
  end

  def enqueue el
    @store1.push el
  end

  def dequeue
    @store1.size.times{ @store2.push(@store1.pop[0]) }
    @store2.pop
    @store2.size.times{ @store1.push(@store2.pop[0]) }
  end

  def peek
    @store1.size.times{ @store2.push(@store1.pop[0]) }
    @store2.peek[0]
    @store2.size.times{ @store1.push(@store2.pop[0]) }
  end

  def max
    @store1.max
  end

  def min
    @store1.min
  end

  def size
    @store1.size
  end

  def empty?
    @store1.empty?
  end
end
