# frozen_string_literal: true

class Gameplay
  BLACK_JACK = 21
  INITIAL_BET = 10

  attr_reader :user, :dealer, :game_bank, :interface, :deck

  def initialize(interface)
    @interface = interface
    @user = User.new(Hand.new, @interface.request_username)
    @dealer = Dealer.new(Hand.new)
    @deck = Deck.new
    @game_bank = 0
  end

  def game_circle
    loop do
      start_game
      flag = auto_place_bet(INITIAL_BET)
      if flag == :error
        @interface.message_game_over
        exit!
      end
      @interface.message_bets_made
      @interface.show_game_bank(user, dealer, game_bank)
      player_steps
      break if @interface.play_again? == false

      play_again
    end
  end

  private

  def start_game
    give_cards_to(@user, 2)
    give_cards_to(@dealer, 2)
    @interface.show_player_cards_info(@user)
    @interface.show_face_down(@dealer)
  end

  def play_again
    @deck = Deck.new
    @user.hand = Hand.new
    @dealer.hand = Hand.new
  end

  def give_cards_to(player, count)
    @deck.cards[0..(count - 1)].each { |card| player.hand.cards << card }
    @deck.cards.shift(count)
  end

  def auto_place_bet(money)
    user_bet = @user.place_bet(money)
    dealer_bet = @dealer.place_bet(money)
    if user_bet != false && dealer_bet != false
      @game_bank += 2 * money
    else :error
    end
  end

  def give_money_to(player, money)
    player.take_money(money)
    @game_bank -= money
  end

  def player_steps
    loop do
      flag = user_step(@interface.select_action)
      break if flag == true

      dealer_step
      flag = open_cards if @user.hand.enough_cards?(3) && @dealer.hand.enough_cards?(3)
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
    @interface.message_make_move(@dealer.name)
    if @dealer.hand.cards_cost_in_hand < 17 && @dealer.hand.enough_cards?(2)
      @interface.message_taking_card(@dealer.name)
      add_card_to_dealer
    else @interface.message_skipping_move(@dealer.name)
    end
  end

  def add_card_to_user
    if @user.hand.enough_cards?(2)
      give_cards_to(@user, 1)
    else @interface.message_max_cards
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
    user_points = @user.hand.cards_cost_in_hand
    dealer_points = @dealer.hand.cards_cost_in_hand
    if user_points > dealer_points && user_points <= BLACK_JACK
      user_wins
    elsif dealer_points <= BLACK_JACK then dealer_wins
    else nobody_wins
    end
  end

  def nobody_wins
    give_money_to(@dealer, INITIAL_BET)
    give_money_to(@user, INITIAL_BET)
    @interface.message_win(:nobody)
    @interface.show_game_bank(user, dealer, game_bank)
  end

  def user_wins
    give_money_to(@user, @game_bank)
    @interface.message_win(:user)
    @interface.show_game_bank(user, dealer, game_bank)
  end

  def dealer_wins
    give_money_to(@dealer, @game_bank)
    @interface.message_win(:dealer)
    @interface.show_game_bank(user, dealer, game_bank)
  end
end
