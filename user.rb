class User < Player
  attr_reader :user_name

  def initialize(user_name = 'guest')
    super()
    @user_name = user_name
  end
end
