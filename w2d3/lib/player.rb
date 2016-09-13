require_relative 'hand'
class Player
  attr_accessor :hand, :pot

  def initialize pot
    @hand = Hand.new
    @pot = pot
  end

  def discard
    display
    puts "discard?"
    to_discard = gets.chomp.split(',').join
    to_discard.each{ |i| @hand.delete_at(i) }

    to_discard.length
  end

  def move
    puts "f, or bet?"
    move = gets.chomp
  end

  def display
    puts  @hand.cards.map(&:to_s).join(" ")
  end

  def over?
    @pot <= 0
  end

  def give_card card
    @hand.cards << card
  end
end
