require_relative 'card'

class Hand
  RANKS = ['sf', '4', 'fh', 'f', 's', '3', '22', '2', '1']

  attr_accessor :cards

  def initialize
    @cards = []
  end

  def better_hand? their_hand
    their_groupings = their_hand.groupings
    groupings.each_with_index do |group, i|
      if group.class == String
        our_rank = RANKS.index(group)
        their_rank = RANKS.index(their_groupings[i])

        next if our_rank == their_rank
        return our_rank < their_rank
      else
        next if group == their_groupings[i]
        return group > their_groupings[i]
      end
    end
    return "tie."
  end

  def groupings
    groupings =
      case
        when flush && straight then ['sf', straight.value]

        when four_of_a_kind then ['4', four_of_a_kind.value]

        when three_of_a_kind && pairs then ['fh', three_of_a_kind.value]

        when flush then ['f']

        when straight then ['s', straight.value]

        when three_of_a_kind then ['3', three_of_a_kind.value]

        when !(pairs.nil?) && pairs.length == 4
          ['22', pairs[-1].value, pairs[0].value]

        when !(pairs.nil?) && pairs.length == 2
          ['2', pairs[-1].value]
        else
          []
        end

    groupings += ['1']
    groupings += @cards.map(&:value).sort.reverse
  end

  def flush
    suits = @cards.map(&:suit).uniq

    @cards[0] if suits.length == 1
  end

  def straight
    values = @cards.map(&:value)
    value_indices = values.map{ |value| Card::VALUES.index(value) }.sort

    value_indices[0..-2].each_with_index do |value, i|
      return nil unless value_indices[i + 1] == value + 1
    end

    @cards.max_by(&:value)
  end

  def pairs
    values = @cards.map(&:value)

    pairs = @cards.select{ |card| values.count(card.value) == 2 }
    pairs.sort_by!{ |card| Card::VALUES.index(card.value) }

    return nil if pairs == []
    pairs
  end

  def three_of_a_kind
    values = @cards.map(&:value)
    @cards.find{ |card| values.count(card.value) == 3 }
  end

  def four_of_a_kind
    values = @cards.map(&:value)
    @cards.find{ |card| values.count(card.value) == 4 }
  end
end
