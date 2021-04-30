require_relative 'gameplay'
require_relative 'player'
require_relative 'user'
require_relative 'hand'
require_relative 'dealer'
require_relative 'card'
require_relative 'deck'
require_relative 'interface'

class Main
  gameplay = Gameplay.new(Interface.new)
  gameplay.game_circle
  exit!
end
