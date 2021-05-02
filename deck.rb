# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    @cards = shuffle_cards!(create_deck)
  end

  def create_deck
    cards = []
    suits.each do |suit_value|
      suit = suit_value
      ranks.each do |rank_value|
        rank = rank_value
        cards << Card.new(rank, suit)
      end
    end
    cards
  end

  def shuffle_cards!(cards)
    cards.shuffle!
  end

  def ranks
    %w[2 3 4 5 6 7 8 9 10 J Q K A]
  end

  def suits
    %w[+ <3 ^ <>]
  end
end
