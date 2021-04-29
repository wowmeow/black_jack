class Card
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[+ <3 ^ <>].freeze

  @card_deck = []

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def self.card_deck
    SUITS.each do |suit_value|
      suit = suit_value
      RANKS.each do |rank_value|
        rank = rank_value
        @card_deck << new(rank, suit)
      end
    end
    @card_deck
  end
end
