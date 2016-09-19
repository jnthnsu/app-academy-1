DICT = {}
f = File.open('dictionary.txt', 'r')
f.each_line do |line|
  DICT[line.chomp] = nil
end

class Game
  attr_accessor :players, :fragment, :losses

  def initialize *players
    @players = players
    @fragment = ''
    @losses = @players.each_with_object({}) do |player, hash|
      hash[player] = 0
    end
  end

  def play_round
    take_turn(@players[0])
    next_player!
  end

  def next_player!
    @players.rotate!
  end

  def take_turn player
    new_string = ''
    while !valid_play?(new_string)
      new_string = gets.chomp
    end
    @fragment << new_string
  end

  def valid_play? string
    return false if string.length != 1 || string.match(/[a-zA-Z]/) == nil

    new_fragment = @fragment.dup.concat(string)
    p DICT.key?(new_fragment)
    p DICT.keys.select{|word| word[0..new_fragment.length - 1] == new_fragment}
    return false if DICT.keys.select{|word| word[0..new_fragment.length - 1] == new_fragment} == []
    return true
  end

  def record player
    "GHOST"[0...@losses[player]]
  end

  def display_standings
    @losses.each do |player, _|
        p player, record(player)
    end
  end

  def run
    until @players.length == 1
      display_standings
      play_round until DICT.key?(@fragment)
      @losses[@players.last] += 1
      @players.pop if @losses[@players.last] == 5
      @fragment = ''
    end
    display_standings
  end

end
