class LRUCache
   def initialize size
     @stack = []
     @size = size
   end

   def count
     # returns number of elements currently in cache
     @stack.length
   end

   def add(el)
     # adds element to cache according to LRU principle
     if @stack.include? el
       @stack.delete(el)
       @stack.push el
     else
       @stack.shift if count == @size
       @stack.push el
     end

   end

   def show
     # shows the items in the cache, with the LRU item first
     @stack
   end

   private
   # helper methods go here!

 end
