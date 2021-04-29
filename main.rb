require_relative 'gameplay'
require_relative 'card'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'interface'

class Main
  gameplay = Gameplay.new
  gameplay.start
end