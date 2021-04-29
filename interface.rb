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
end