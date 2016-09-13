require 'card'
require 'deck'
require 'game'
require 'hand'
require 'player'
require 'rspec'

describe Card do
  subject(:good_card){ Card.new('diamond', 2)}

  subject(:bad_suit){ Card.new('cool', 2)}
  subject(:bad_value){ Card.new('heart', 'to')}

  describe "#initialize" do
    context 'good_cards' do
      it "initializes" do
        expect(good_card.suit).to eq('diamond')
        expect(good_card.value).to eq(2)
      end
    end

    context 'bad_cards' do
      it "raises error if incorrect suit" do
        expect{bad_suit}.to raise_error(ArgumentError)
      end

      it "raises error if incorrect value" do
        expect{bad_value}.to raise_error(ArgumentError)
      end
    end
  end
end

describe Deck do
  subject(:deck){ Deck.new }

  describe "#initialize" do
    it "initializes with shuffled deck" do
       cards = deck.deck

       suits = cards.map(&:suit)
       values = cards.map(&:value)

       suit_count = Array.new(4){|i| suits.count(Card::SUITS[i])}
       value_count = Array.new(13){|i| values.count(Card::VALUES[i])}

       expect(suit_count).to eq(Array.new(4){13})
       expect(value_count).to eq(Array.new(13){4})
       expect(cards[0]).to_not eq(Card.new("diamond",2))
     end
  end

  describe "#remove_card" do
    it "removes and returns one card by default" do
      expect(deck.remove_card.length).to eq(1)
      expect(deck.deck.length).to eq(51)
    end

    it "removes and returns n cards" do
      expect(deck.remove_card(3).length).to eq(3)
      expect(deck.deck.length).to eq(49)
    end
  end
end

describe Hand do
  let(:royal_flush) do
      Array.new(5){ |i| Card.new('spade', Card::VALUES[-i-1]) }
  end
  let(:straight) do
      Array.new(5){|i| Card.new('club', Card::VALUES[i])}
  end
  let(:my_hand) {Hand.new(royal_flush)}
  let(:their_hand) {Hand.new(straight)}

  describe "#initialize" do
    it "creates a hand"  do
      expect(my_hand.cards).to eq(royal_flush)
    end
  end

  describe "#better_hand" do
    it "checks the better hand" do
      expect(my_hand.better_hand?their_hand).to be_truthy
      expect(their_hand.better_hand? my_hand).to be_falsey
      expect(my_hand.better_hand?my_hand).to eq("tie.")
    end
  end
end
