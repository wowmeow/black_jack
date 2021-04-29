class Player
  attr_reader :cards, :money, :total_points

  def initialize
    @money = initial_money
    @cards = []
  end

  def place_bet(money)
    @money -= money
  end

  def take_money(money)
    @money += money
  end

  def cards_cost_of_player
    cards_cost = 0
    @cards.each do |card|
      price = if %w[J Q K].include?(card.rank)
                10
              elsif %w[2 3 4 5 6 7 8 9 10].include?(card.rank) then card.rank.to_i
              elsif cards_cost + 11 < 21 then 11
              else 1 end
      cards_cost += price
    end
    cards_cost
  end

  private

  def initial_money
    100
  end
end
