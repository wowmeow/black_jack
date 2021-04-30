class Interface
  def request_username
    puts 'Ваше имя:'
    gets.chomp
  end

  def show_face_up(player)
    name = player.instance_of?(User) ? player.username : 'Дилер'
    print "Карты игрока #{name}: "
    player.hand.cards.each { |card| print "#{card.rank + card.suit} " }
    puts
  end

  def show_face_down(player)
    puts "Карты игрока Дилер: #{'* ' * player.hand.cards.count}"
  end

  def show_card_cost(player)
    name = player.instance_of?(User) ? player.username : 'Дилер'
    puts "Сумма очков у игрока #{name}: #{player.hand.cards_cost_in_hand}"
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

  def play_again?
    input = ''
    loop do
      puts "\n\nХотите сыграть еще раз? (да/нет)"
      input = gets.chomp
      break if %w[да нет].include?(input)
    end
    input != 'нет'
  end

  def message(text)
    puts "\n#{text}"
  end
end
