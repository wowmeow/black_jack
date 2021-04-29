class Interface
  def add_user
    puts "Ваше имя:"
    user_name = gets.chomp
    User.new(user_name)
  end

  def show_user_cards(cards)
    puts "Ваши карты:"
    cards.each { |card| print "#{card.rank + card.suit} " }
    puts
  end

  def show_dealer_cards(cards)
    puts "Карты дилера: #{'* ' * cards.count}"
  end

  def show_card_cost(cards_cost)
    puts "Сумма Ваших очков: #{cards_cost}"
  end

  def show_game_bank(user, dealer, game_bank)
    puts "\nСтавки сделаны, ставок больше нет!"
    puts "У вас осталось: #{user.money}$"
    puts "У дилера осталось: #{ dealer.money}$"
    puts "В банке игры: #{game_bank}$"
  end
end