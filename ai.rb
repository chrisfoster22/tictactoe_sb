class Ai

  attr_reader :moves

  def initialize
    @moves = []
  end

  def move(board)
    possible_moves = board.possible_moves
    move = possible_moves.sample
    move = for_the_win(board) || board.potential_win || move
    if @moves.count < 2
      move = "M2" if possible_moves.include?("M2")
      move = respond_to_side(board.last_move) if board.sides.include?(board.last_move)
      move = respond_to_corner(board.last_move) if board.corners.include?(board.last_move)
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
    possibility = []
    move = nil
    board.winning_moves.each do |p|
      possible_moves = p if (@moves & p).count == 2
      if possible_moves
        possibility = possible_moves - @moves
        move = possibility.sample if board.possible_moves.include?(move)
      end
    end
    move
  end
end
