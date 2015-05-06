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
    @turn = 0
  end

  def active_player
    @turn += 1
    if @turn.odd?
      return @ai
    else
      return @human
    end
  end

  def move(coordinate)
    @moves << coordinate
  end

  def over?
    @board.possible_moves.empty?
  end

end
