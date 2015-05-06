class Ai

  attr_reader :moves

  def initialize
    @moves = []
  end

  def move(board)
    move = "M2" if board.possible_moves.include?("M2")
    move = respond_to_side(board.last_move) if board.sides.include?(board.last_move)
    move = respond_to_corner(board.last_move) if board.corners.include?(board.last_move)
    @moves << move
    move
  end

  def respond_to_side(last_play)
    if last_play == "T2" || "M3"
      "B1"
    elsif last_play == "B2" || "M1"
      "T3"
    end
  end

  def respond_to_corner(last_play)
    if last_play == "T1"
      @play = "B3"
    elsif last_play == "T3"
      @play = "B1"
    elsif last_play == "B1"
      @play = "T3"
    elsif last_play == "B3"
      @play = "T1"
    end
  end

end
