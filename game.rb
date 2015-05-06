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

  def play
    until over? || winner
      player = active_player
      if player.class == Ai
        puts 'My turn!'
        move = @ai.move(@board)
        @board.add_move(move, @ai)
      elsif player.class == Player
        puts 'Your turn!'
        move = gets.chomp
        @board.add_move(move, @human)
      end
      puts @board.display
    end
  end

  def over?
    @board.possible_moves.empty?
  end

  def winner
    @board.winning_moves.each do |w|
      if (@board.ai_moves & w).sort == w.sort
        puts "You Lost!"
        return @ai
      elsif (@board.player_moves & w).sort == w.sort
        puts "You Won!"
        return @human
      end
    end
    return nil
  end

end
