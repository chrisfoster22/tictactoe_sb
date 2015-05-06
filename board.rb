class Board

  def initialize
    @top = ["_", "_", "_"]
    @middle = ["_","_", "_"]
    @bottom = [" ", " ", " "]
    @rows = [@top, @middle, @bottom]
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
    split_coords = coordinate.split("")
    row = find_row(split_coords.first)
    column = (split_coords.last.to_i) - 1
    if player.class == Ai
      row[column] = "X"
    else
      row[column] = "O"
    end
  end

  def find_row(row)
    value = @top if row == "T"
    value = @middle if row == "M"
    value = @bottom if row == "B"
    value
  end

end
