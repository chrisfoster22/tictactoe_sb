class Ai

  attr_reader :moves

  def initialize
    @moves = []
  end

  def move(board)
    move = board.possible_moves.sample
    @moves << move
    move
  end
end
