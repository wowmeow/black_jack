class Interface
  def add_user
    puts 'Ваше имя:'
    user_name = gets.chomp
    User.new(user_name)
  end

  def show_face_up(cards)
    puts 'Ваши карты:'
    cards.each { |card| print "#{card.rank + card.suit} " }
    puts
  end

  def show_face_down(cards)
    puts "Карты дилера: #{'* ' * cards.count}"
  end

  def show_card_cost(cards_cost)
    puts "Сумма Ваших очков: #{cards_cost}"
  end

  def show_game_bank(user, dealer, game_bank)
    puts "\nСтавки сделаны, ставок больше нет!"
    puts "У вас осталось: #{user.money}$"
    puts "У дилера осталось: #{dealer.money}$"
    puts "В банке игры: #{game_bank}$"
  end

  def select_action
    input = 0
    loop do
      puts "Ваш ход, выберете действие:
    1 - пропустить ход
    2 - добавить карту
    3 - открыть карты"
      input = gets.chomp.to_i
      break if [1, 2, 3].include?(input)
    end
    input
  end
end