class Gameplay
  attr_reader :user, :dealer, :cards, :game_bank

  def initialize
    @interface = Interface.new
    @user = @interface.add_user
    @dealer = Dealer.new
    @cards = Card.card_deck.shuffle!
    @game_bank = 0
  end

  def start
    give_cards_to(user, 2)
    give_cards_to(dealer, 2)

    @interface.show_user_cards(user.cards)
    @interface.show_dealer_cards(dealer.cards)
    @interface.show_card_cost(@user.cards_cost)

    auto_place_bet(10)
    @interface.show_game_bank(user, dealer, game_bank)
  end

  def give_cards_to(player, count)
    @cards[0..(count - 1)].each { |card| player.cards << card }
    @cards.drop(count - 1)
  end

  def auto_place_bet(money)
    @user.place_bet(money)
    @dealer.place_bet(money)
    @game_bank += 2 * money
  end
end
