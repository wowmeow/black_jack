# frozen_string_literal: true

class Dealer < Player
  attr_reader :name

  def initial
    super
    @name = 'Dealer'
  end
end
