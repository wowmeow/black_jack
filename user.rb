class User < Player
  attr_reader :username

  def initialize(hand, username = 'guest')
    super(hand)
    @username = username
  end
end
