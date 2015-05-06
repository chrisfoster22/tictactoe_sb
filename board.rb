class Board

  attr_reader :possible_moves, :player_moves, :ai_moves, :winning_moves

  def initialize
    @top = ["_", "_", "_"]
    @middle = ["_","_", "_"]
    @bottom = [" ", " ", " "]
    @rows = [@top, @middle, @bottom]
    @ai_moves = []
    @player_moves = []
    @possible_moves = ["T1", "T2", "T3", "M1", "M2", "M3", "B1", "B2", "B3"]
    @winning_moves = [["T1", "T2", "T3"], ["B1", "B2", "B3"], ["M1", "M2", "M3"],
                        ["T1", "M1", "B1"], ["T2", "M2", "B2"], ["T3", "M3", "B3"],
                        ["T1", "M2", "B3"], ["T3", "M2", "B1"]]
  end

  def display
    output = ""
    @rows.each do |r|
      output << r.join("|")
      output << "\n"
    end
    output
  end

  def add_move(coordinate, player)
    return "Sorry, that is an invalid move" unless @possible_moves.include?(coordinate)
    split_coords = coordinate.split("")
    row = find_row(split_coords.first)
    column = (split_coords.last.to_i) - 1
    if player.class == Ai
      row[column] = "X"
      @ai_moves << coordinate
    elsif player.class == Player
      row[column] = "O"
      @player_moves << coordinate
    end
    @possible_moves.delete(coordinate)
  end

  def find_row(row)
    value = @top if row == "T"
    value = @middle if row == "M"
    value = @bottom if row == "B"
    value
  end

end
