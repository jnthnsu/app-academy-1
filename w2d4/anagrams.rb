require 'benchmark'
#O(n!)

def first_anagram?(str1, str2)
  anagram(str1).include?(str2)
end

def anagram(str)
  return [str] if str.length <= 1
  last = anagram(str[1..-1]).uniq
  p last
  last.each_with_object([]) do |word, arr|
    word.length.times do |i|
      arr << word.dup.insert(i, str[0])
    end
  end

end

#O(n^2)

def second_anagram?(str1, str2)

    str1.chars.each_with_index do |char1, i|
      str2.chars.each_with_index do |char2, j|
        if char2 == char1
          str1.delete!(char1)
          str2.delete!(char2)
        end
      end
  end

  str1.empty? && str2.empty?

end

#O(n^2)

def third_anagram?(str1, str2)
  str1.split("").sort == str2.split("").sort
end


#O(n)

def fourth_anagram?(str1, str2)
  hash1 = Hash.new(0)
  hash2 = Hash.new(0)

  str1.chars.each do |char|
    hash1[char] += 1
  end

  str2.chars.each do |char|
    hash2[char] += 1
  end

  hash1 == hash2

end


def fifth_anagram?(str1, str2)
  hash1 = Hash.new(0)

  str1.chars.each do |char|
    hash1[char] += 1
  end

  str2.chars.each do |char|
    hash1[char] -= 1
  end

  hash1.values.all? { |value| value == 0 }
end

p fifth_anagram?("gizmo", "sally")
p fifth_anagram?("elvis", "lives")
