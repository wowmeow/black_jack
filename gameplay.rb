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

  def game_circle
    give_cards_to(@user, 2)
    give_cards_to(@dealer, 2)
    @interface.show_player_cards_info(@user)
    @interface.show_face_down(@dealer)
    auto_place_bet(initial_bet)
    @interface.message("Ставки сделаны, ставок больше нет!")
    @interface.show_game_bank(user, dealer, game_bank)
    player_steps
  end

  private

  def give_cards_to(player, count)
    @cards[0..(count - 1)].each { |card| player.cards << card }
    @cards.shift(count)
  end

  def auto_place_bet(money)
    @user.place_bet(money)
    @dealer.place_bet(money)
    @game_bank += 2 * money
  end

  def give_money_to(player, money)
    player.take_money(money)
    @game_bank -= money
  end

  def player_steps
    loop do
      user_step(@interface.select_action)
      dealer_step
      open_cards if @user.cards.count == 3 && @dealer.cards.count == 3
    end
  end

  def user_step(select_action)
    case select_action
    when 2 then add_card_to_user
    when 3 then open_cards
    else 'Error!'
    end
  end

  def dealer_step
    @interface.message("Ход игрока Дилер")
    if @dealer.cards_cost_of_player < 17
      @interface.message('Игрок Дилер взял карту')
      add_card_to_dealer
    else
      @interface.message('Игрок Дилер пропустил ход')
    end
  end

  def add_card_to_user
    raise "Должно быть ровно 2 карты. У Вас их #{@user.cards.count}." if @user.cards.count != 2

    give_cards_to(@user, 1)
    @interface.show_player_cards_info(@user)
  end

  def add_card_to_dealer
    give_cards_to(@dealer, 1)
    @interface.show_face_down(@dealer)
  end

  def open_cards
    @interface.show_player_cards_info(@user)
    @interface.show_player_cards_info(@dealer)
    results
  end

  def results
    user_points = @user.cards_cost_of_player
    dealer_points = @dealer.cards_cost_of_player
    if user_points > dealer_points && user_points <= BLACK_JACK
      user_wins
    elsif dealer_points <= BLACK_JACK then dealer_wins
    else nobody_wins
    end
    exit!
  end

  def nobody_wins
    give_money_to(@dealer, initial_bet)
    give_money_to(@user, initial_bet)
    @interface.message("Ничья. Деньги возвращаются обратно игрокам:")
    @interface.show_game_bank(user, dealer, game_bank)
  end

  def user_wins
    give_money_to(@user, @game_bank)
    @interface.message("Поздравляем! Вы выиграли игру.")
    @interface.show_game_bank(user, dealer, game_bank)
  end

  def dealer_wins
    give_money_to(@dealer, @game_bank)
    @interface.message("Выиграл игрок Дилер.")
    @interface.show_game_bank(user, dealer, game_bank)
  end

  def initial_bet
    10
  end
end
