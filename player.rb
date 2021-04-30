class Player
  attr_reader :money
  attr_accessor :hand

  def initialize(hand)
    @money = initial_money
    @hand = hand
  end

  def place_bet(money)
    if (@money - money).positive?
      @money -= money
    else false
    end
  end

  def take_money(money)
    @money += money
  end

  private

  def initial_money
    100
  end
end
