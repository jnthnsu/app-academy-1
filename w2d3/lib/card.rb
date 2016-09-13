require 'colorize'

class Card
  SUITS  = %w"diamond heart club spade"
  VALUES = (1..13).to_a

  SYMBOLS = Hash.new
  hash = {spade: 'A', heart: 'B', diamond: 'C', club: 'D'}
  cards = SUITS.product(VALUES)
  cards.each do |card|
    suit, value = card
    SYMBOLS[card] = '0x1F0' + hash[suit.to_sym] + value.to_s(16)
  end

  attr_reader :suit, :value

  def initialize  suit, value
    raise ArgumentError unless SUITS.include?(suit) && VALUES.include?(value)
    @suit, @value = suit , value
  end

  def to_s
    SYMBOLS[[@suit, @value]].to_i(16).chr('utf-8')
  end
end
