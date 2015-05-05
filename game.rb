require_relative 'ai'
require_relative 'player'

class Game

  attr_reader :moves, :players, :human, :ai

  def initialize
    @moves = []
    @human = Player.new
    @ai = Ai.new
    @players = [@ai, @human]
  end

  def move(coordinate)
    @moves << coordinate
  end

end
