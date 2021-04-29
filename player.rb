class Player
  attr_reader :money, :total_points
  attr_accessor :cards

  def initialize
    @money = initial_money
    @cards = []
  end

  def place_bet(money)
    if @money - money > 0
      @money -= money
    else false
    end
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
