require_relative 'deck'
require_relative 'player'
require_relative 'hand'

class Game
  attr_reader :deck, :pot
  def initialize players
      @deck, @players , @pot = Deck.new, players, 0
  end

  def deal
    5.times do
      @players.each do |player|
        player.give_card(@deck.remove_card)
      end
    end
  end

  def run
    until @players.length <= 1
      @players.each{ |player| player.hand = Hand.new }
      deal

      bet = 0
      @pot = 0

      players = @players.clone

			raised = true
			last = players.length

			while raised
				raised = false

		    players.each_with_index do |player, i|
					break if i == last

		      puts "bet = #{bet}"
		      move = player.move

		      if move == 'f'
		        players.delete(player)
		      else
		        player.pot -= move.to_i
		        @pot += move.to_i

						prev_bet = bet
		        bet = move.to_i

						if bet > prev_bet
							raised = true
							last = i
						end
		      end
		    end
			end

      players.each do |player|
				player.display
        puts player.pot
			end

      if players.length == 1
        players[0].pot += @pot
        next
      end

    	winners = [players[0]]
      players[0..-2].each_with_index do |player, i|
        winners =
          case winners[0].hand.better_hand?(players[i+1].hand)
            when 'tie.' then [player, players[i+1]]
            when true then [player]
            else [players[i+1]]
          end
      end

      winners.each {|winner| winner.pot += pot / winners.length }

      @players.reject!{ |player| player.over? }
    end
    @players[0]
  end
end

p1 = Player.new(500)
p2 = Player.new(500)

g = Game.new([p1, p2])
g.run
