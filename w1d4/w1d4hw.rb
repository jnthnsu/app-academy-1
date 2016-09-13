class Stack
  attr_accessor :stack

  def initialize
    @stack = []
  end

  def add el
    @stack.push(el)
  end

  def remove
    @stack.pop
  end

  def show
    stack
  end
end

class Queue
  attr_accessor :queue

  def initialize
    @queue = []
  end

  def enqueue el
    @queue.push(el)
  end

  def dequeue
    @queue.shift
  end

  def show
    queue
  end
end

class Map
  attr_accessor :map

  def initialize
    @map = []
  end

  def assign k, v
    @map << [k, v]
  end

  def lookup k
    @map.select{|pair| pair.first == k}[0]
  end

  def remove k
    @map.reject!{|pair| pair.first == k}
  end
end
