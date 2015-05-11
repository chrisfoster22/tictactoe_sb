require_relative 'ai'
require_relative 'player'
require_relative 'board'

class Game

  attr_reader :moves, :players, :human, :ai, :board
  attr_accessor :first_player, :turn

  def initialize
    @moves = []
    @human = Player.new
    @ai = Ai.new
    @players = [@ai, @human]
    @board = Board.new
    @turn = 0
    @first_player = @players.sample
    @second_player = (@players - [@first_player]).sample
  end

  def active_player
    @turn += 1
    if @turn.odd?
      @first_player
    else
      @second_player
    end
  end

  def play
    until over? || winner
      player = active_player
      if player.class == Ai
        puts 'My turn!'
        ai.move(@board)
      elsif player.class == Player
        puts 'Your turn!'
        move = @board.possible_moves.sample
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
      if (@ai.moves & w).sort == w.sort
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
