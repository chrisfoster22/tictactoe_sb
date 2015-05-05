class Game

  attr_reader :moves

  def initialize
    @moves = []
  end

  def move(coordinate)
    @moves << coordinate
  end

end
