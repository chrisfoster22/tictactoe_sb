class Ai

  attr_reader :moves

  def initialize
    @moves = []
  end

  def move(board)
    move = [""]
    until board.possible_moves.include?(move)
      move = board.possible_moves.sample
      move = board.potential_win
      move = for_the_win(board)
      if @moves.count < 2
        move = "M2" if board.possible_moves.include?("M2")
        move = respond_to_side(board.last_move) if board.sides.include?(board.last_move)
        move = respond_to_corner(board.last_move) if board.corners.include?(board.last_move)
      end
    end

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

  def for_the_win(board)
    move = []
    board.winning_moves.each do |p|
      move = p if (@moves & p).count == 2
    end
    move = move - @moves
    move = move.first
    move unless move == nil
  end

end
