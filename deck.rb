# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    @cards = shuffle_cards!(create_deck)
  end

  def create_deck
    cards = []
    SUITS.each do |suit_value|
      suit = suit_value
      RANKS.each do |rank_value|
        rank = rank_value
        cards << Card.new(rank, suit)
      end
    end
    cards
  end

  def shuffle_cards!(cards)
    cards.shuffle!
  end
end
