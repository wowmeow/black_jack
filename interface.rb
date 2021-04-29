class Interface
  def add_user
    puts 'Ваше имя:'
    user_name = gets.chomp
    User.new(user_name)
  end

  def show_face_up(player)
    name = player.instance_of?(User) ? player.user_name : 'Дилер'
    print "Карты игрока #{name}: "
    player.cards.each { |card| print "#{card.rank + card.suit} " }
    puts
  end

  def show_face_down(player)
    puts "Карты игрока Дилер: #{'* ' * player.cards.count}"
  end

  def show_card_cost(player)
    name = player.instance_of?(User) ? player.user_name : 'Дилер'
    puts "Сумма очков у игрока #{name}: #{player.cards_cost_of_player}"
  end

  def show_player_cards_info(player)
    show_face_up(player)
    show_card_cost(player)
  end

  def show_game_bank(user, dealer, game_bank)
    puts "\nУ Вас: #{user.money}$"
    puts "У игрока Дилер: #{dealer.money}$"
    puts "В банке игры: #{game_bank}$"
  end

  def select_action
    input = 0
    loop do
      puts "\nВаш ход, выберете действие:
    1 - пропустить ход
    2 - добавить карту
    3 - открыть карты"
      input = gets.chomp.to_i
      break if [1, 2, 3].include?(input)
    end
    input
  end

  def message(text)
    puts "\n#{text}"
  end
end
