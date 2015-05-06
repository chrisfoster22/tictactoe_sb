require_relative 'ai'
require_relative 'player'
require_relative 'board'

class Game

  attr_reader :moves, :players, :human, :ai, :board

  def initialize
    @moves = []
    @human = Player.new
    @ai = Ai.new
    @players = [@ai, @human]
    @board = Board.new
  end

  def move(coordinate)
    @moves << coordinate
  end

end
