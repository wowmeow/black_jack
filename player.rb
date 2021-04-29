class Player
  attr_reader :cards, :money, :total_points

  def initialize
    @money = initial_money
    @cards = []
  end

  def place_bet(money)
    @money -= money
  end

  def cards_cost
    cards_cost = 0
    @cards.each do |card|
      rank = begin
        Integer(card.rank)
      rescue StandardError
        false
      end
      price = if rank
                rank
              elsif card.rank == 'J' || card.rank == 'Q' || card.rank == 'K'
                10
              elsif cards_cost + 11 < 21
                11
              else
                1
              end
      cards_cost += price
    end
    cards_cost
  end

  private

  def initial_money
    100
  end

end