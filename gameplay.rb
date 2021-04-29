require_relative 'card'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'interface'

class Gameplay
  attr_reader :user, :dealer

  def start
    interface = Interface.new
    @user = interface.add_user
    @dealer = Dealer.new
    # перемешать колоду
    @cards = Card.card_deck.shuffle!
    # раздать карты
    give_cards_to(user, 2)
    give_cards_to(dealer, 2)
    # посмтреть карты
    interface.show_user_cards(user.cards)
    interface.show_dealer_cards(dealer.cards)

    @user.total_points
  end

  def give_cards_to(player, count)
    @cards[0..(count - 1)].each { |card| player.cards << card }
    @cards.drop(count - 1)
  end


end
