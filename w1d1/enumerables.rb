require 'byebug'

class Array
  def my_each &block
    self.length.times do |i|
      block.call(self[i])
    end
    self
  end

  def my_select &block
    new_array = []
    self.my_each{|x| new_array << x if block.call(x) == true}
    new_array
  end

  def my_reject &block
    self - self.my_select(&block)
  end

  def my_any? &block
    self.my_select(&block).length > 0
  end

  def my_all? &block
    self.my_select(&block).length == self.length
  end

  def my_flatten(new_array = [])
    self.each do |x|
      if x.is_a?(Array)
        x.my_flatten(new_array)
      else
        new_array << x
      end
    end
    new_array
  end

  def my_zip(*args)
    new_array = []
    self.each_with_index do |x, idx|
      second_array = [x]
      args.each do |arg|
        if idx < arg.length
          second_array.push(arg[idx])
        else
          second_array.push(nil)
        end
      end
      new_array.push(second_array)
    end
    new_array
  end

  def my_rotate(shift = 1)
    new_array = []
    while new_array.length < self.length
      new_array.push(self[shift % self.length])
      shift += 1
    end
    new_array
  end

  def my_join(str = '')
    new_string = ''
    self.each do |s|
      new_string.concat(s).concat(str)
    end
    str.length.times{new_string.chop!}
    new_string
  end

  def my_reverse
    new_array = []
    (self.length - 1).downto(0).each do |idx|
      new_array << self[idx]
    end
    new_array
  end
end
