class Gameplay
  BLACK_JACK = 21
  INITIAL_BET = 10

  attr_reader :user, :dealer, :game_bank, :interface, :deck

  def initialize(interface)
    @interface = interface
    @user = User.new(@interface.add_user)
    @dealer = Dealer.new
    @deck = Deck.new
    @game_bank = 0
  end

  def game_circle
    loop do
      give_cards_to(@user, 2)
      give_cards_to(@dealer, 2)
      @interface.show_player_cards_info(@user)
      @interface.show_face_down(@dealer)
      flag = auto_place_bet(INITIAL_BET)
      if flag == :error
        @interface.message('Один из игроков банкрот! Игра закончилась :(')
        exit!
      end
      @interface.message("Ставки сделаны, ставок больше нет!")
      @interface.show_game_bank(user, dealer, game_bank)
      player_steps
      break if @interface.play_again? == false

      @deck = Deck.new
      @user.cards = []
      @dealer.cards = []
    end
  end

  private

  def give_cards_to(player, count)
    @deck.cards[0..(count - 1)].each { |card| player.cards << card }
    @deck.cards.shift(count)
  end

  def auto_place_bet(money)
    user_bet = @user.place_bet(money)
    dealer_bet = @dealer.place_bet(money)
    if user_bet != false && dealer_bet != false
      @game_bank += 2 * money
    else
      :error
    end
  end

  def give_money_to(player, money)
    player.take_money(money)
    @game_bank -= money
  end

  def player_steps
    flag = false
    loop do
      flag = user_step(@interface.select_action)
      break if flag == true

      dealer_step
      flag = open_cards if @user.cards.count == 3 && @dealer.cards.count == 3
      break if flag == true
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
    if @dealer.cards_cost_of_player < 17 && @dealer.cards.count < 3
      @interface.message("Игрок Дилер взял карту")
      add_card_to_dealer
    else
      @interface.message("Игрок Дилер пропустил ход")
    end
  end

  def add_card_to_user
    if @user.cards.count == 2
      give_cards_to(@user, 1)
    else
      @interface.message("У вас уже максимальное количество карт (3 шт.)")
    end
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
    true
  end

  def results
    user_points = @user.cards_cost_of_player
    dealer_points = @dealer.cards_cost_of_player
    if user_points > dealer_points && user_points <= BLACK_JACK
      user_wins
    elsif dealer_points <= BLACK_JACK then dealer_wins
    else nobody_wins
    end
  end

  def nobody_wins
    give_money_to(@dealer, INITIAL_BET)
    give_money_to(@user, INITIAL_BET)
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

end
