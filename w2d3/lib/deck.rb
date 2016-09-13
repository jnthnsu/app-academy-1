require_relative 'card'

class Deck
  attr_accessor :deck

  def initialize

    @deck = all_cards.shuffle
  end

  def all_cards
    (Card::SUITS).product(Card::VALUES).map{|suit, value| Card.new suit, value}
  end

  def remove_card 
    @deck.shift
  end

end
