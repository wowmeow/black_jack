class Card
  NUMBER_FORMAT = [/^\d+$/].freeze # исправить для 2-10
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



  def card_price
    # if rank == 'В' ||== 'Д' ||== 'К'
    #   card_price == 10
    # elsif rank == 'Т'
    #    if (туз - 1 или 11, в зависимости от того, какое значение будет ближе к 21)
    #       card_price = 1
    #   else
    #       card_price = 11
    #   end
    # elsif rank ~= NUMBER_FORMAT
    #   card_price = card_value.to_i
    #
    # end
    #
  end

end
