class Ai

  attr_reader :moves

  def initialize
    @moves = []
  end

  def move(board)
    possible_moves = board.possible_moves
    move = possible_moves.sample
    if @moves.count < 2
      move = board.corners.sample
      move = respond_to_side(board.last_move) if board.sides.include?(board.last_move)
      move = respond_to_corner(board.last_move) if board.corners.include?(board.last_move)
      move = respond_to_blitz(board) if (board.sides & board.possible_moves).count == 2
    end
    move = "M2" if possible_moves.include?("M2")
    move = for_the_win(board) || board.potential_win || move
    @moves << move
    move
  end

  def respond_to_side(last_play)
    if last_play == "T2" || last_play == "M3"
      "B1"
    elsif last_play == "B2" || last_play == "M1"
      "T3"
    end
  end

  def respond_to_corner(last_play)
    if last_play == "T1"
      "B3"
    elsif last_play == "T3"
      "B1"
    elsif last_play == "B1"
      "T3"
    elsif last_play == "B3"
      "T1"
    end
  end

  def respond_to_blitz(board)
    sides = board.sides
    possible_moves = board.possible_moves
    blitz = sides & possible_moves
    sorted_blitz = blitz.sort
    board.corners.sample 
    "T3" if sorted_blitz == ["T2", "M3"].sort
    "T1" if sorted_blitz == ["T2", "M1"].sort
    "B1" if sorted_blitz == ["M1", "B2"].sort
    "B3" if sorted_blitz == ["M3", "B2"].sort
  end

  def for_the_win(board)
    move = nil
    board.winning_moves.each do |p|
      if (@moves & p).count == 2
        possibility = p - @moves
        move = possibility.sample 
        board.possible_moves.include?(move) ? break : move = nil
      end
    end
    move
  end
end
