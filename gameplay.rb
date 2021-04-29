class Gameplay
  BLACK_JACK = 21

  attr_reader :user, :dealer, :cards, :game_bank, :interface

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

    @interface.show_face_up(user.cards)
    @interface.show_face_down(dealer.cards)
    @interface.show_card_cost(@user.cards_cost)

    auto_place_bet(initial_bet)
    @interface.show_game_bank(user, dealer, game_bank)

    user_step(@interface.select_action)
  end

  def give_cards_to(player, count)
    @cards[0..(count - 1)].each { |card| player.cards << card }
    @cards.drop(count - 1)
  end

  private

  def auto_place_bet(money)
    @user.place_bet(money)
    @dealer.place_bet(money)
    @game_bank += 2 * money
  end

  def give_money_to(player, money)
    player.take_money(money)
  end

  def user_step(select_action)
    case select_action
    when 2 then add_card(@user)
    when 3 then open_cards
    end
  end

  def add_card(player)
    raise "Должно быть ровно 2 карты. У Вас их #{@user.cards.count}." if @user.cards.count != 2

    give_cards_to(player, 1)
    @interface.show_face_up(player.cards)
    @interface.show_card_cost(player.cards_cost)
  end

  def open_cards
    show_face_up(@user)
    show_card_cost(user.cards_cost)
    show_face_up(@dealer)
    show_card_cost(@dealer.cards_cost)
    result
  end

  def results
    user_points = @user.cards_cost
    dealer_points = @dealer.cards_cost
    if (user_points == dealer_points) || (user_points > BLACK_JACK && dealer_points > BLACK_JACK)
      give_money_to(@dealer, initial_bet)
      give_money_to(@user, initial_bet)
      :nobody
    elsif user_points > dealer_points && user_points <= BLACK_JACK
      give_money_to(@user, @game_bank)
      :user
    elsif user_points < dealer_points && dealer_points <= BLACK_JACK
      give_money_to(@dealer, @game_bank)
      :dealer
    end
  end

  def initial_bet
    10
  end

end
