class User < Player
  attr_reader :user_name

  def initialize(name = 'guest')
    super()
    @user_name = name
  end
end