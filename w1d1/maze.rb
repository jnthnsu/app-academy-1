require 'matrix'

class Matrix
  def [] i, j
    self[i][j]
  end
  def []= i, j, value
    self[i][j] = value
  end
end

file = gets.chomp

file = File.readlines(file, 'r')


length = file.length
width = file[0].length

maze = Matrix.build(length, width){nil}

file.each_with_index do |line, i|
  line.each_char.with_index do |char, j|
    maze[i,j] = char
  end
end

file.close

path = [maze.find_index("S")]


def solver
  until maze[*path.last] == "E"
    if valid_move(path)[0]
      path << valid_move(path)[1]
    else
      path.pop
    end
  end
  path
end

def valid_move(path)
  pos = path.last
  if maze[pos[0] + 1, pos[1]] != '*' && !path.include?([pos[0] + 1, pos[1]])
    [true, [pos[0] + 1, pos[1]]]
  elsif maze[pos[0], pos[1] + 1] != '*' && !path.include?([pos[0], pos[1] + 1])
    [true, [pos[0], pos[1] + 1]]
  elsif maze[pos[0] - 1, pos[1]] != '*' && !path.include?([pos[0] - 1, pos[1]])
    [true, [pos[0] - 1, pos[1]]]
  elsif maze[pos[0], pos[1] - 1] != '*' && !path.include?([pos[0], pos[1] - 1])
    [true, [pos[0], pos[1] - 1]]
  else
    [false, nil]
  end
end
