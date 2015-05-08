require 'rspec'
require_relative '../game'

RSpec.describe Game do
  before(:each) do
    @game = Game.new
    @players = @game.players
    @board = @game.board
  end

  it 'displays a board' do
    expect(@board.display).to eql "_|_|_\n_|_|_\n | | \n"
  end

  it 'has two players' do
    expect(@players.count).to eql 2
  end

  it 'has an AI player and a Human player' do
    expect(@players.first.class).to eql Ai
    expect(@players.last.class).to eql Player
  end

    it 'alternates turns' do
    @board.add_move("M2", @game.active_player)
    expect(@board.display).to eql "_|_|_\n_|X|_\n | | \n"
    @board.add_move("M1", @game.active_player)
    expect(@board.display).to eql "_|_|_\nO|X|_\n | | \n"
  end

  it 'can end' do
    @board.add_move("M2", @game.active_player)
    @board.add_move("M1", @game.active_player)
    @board.add_move("M3", @game.active_player)
    @board.add_move("T2", @game.active_player)
    @board.add_move("T1", @game.active_player)
    @board.add_move("T3", @game.active_player)
    @board.add_move("B2", @game.active_player)
    @board.add_move("B1", @game.active_player)
    @board.add_move("B3", @game.active_player)
    expect(@game.over?).to eql true
  end

  it 'can be won' do
    @board.add_move("M1", @game.human)
    @board.add_move("M2", @game.human)
    @board.add_move("M3", @game.human)
    expect(@game.winner).to eql @game.human
  end



end

RSpec.describe Board do

  before(:each) do
    @game = Game.new
    @players = @game.players
    @board = @game.board
  end

  it 'adds an X to the board when the AI makes a move' do
    @board.add_move("M2", @game.ai)
    expect(@board.display).to eql "_|_|_\n_|X|_\n | | \n"
  end

  it 'adds an O to the board when the Human makes a move' do
    @board.add_move("M2", @game.human)
    expect(@board.display).to eql "_|_|_\n_|O|_\n | | \n"
  end

  it 'does not allow players to make a move that has already been made' do
    @board.add_move("M2", @game.ai)
    @board.add_move("M2", @game.human)
    expect(@board.player_moves).to eql []
  end

end

RSpec.describe Player do

  before(:each) do
    @game = Game.new
  end

  it 'makes a move' do
    player = @game.human
    player.move("M2")
    expect(player.moves).to eql ["M2"]
  end

end

RSpec.describe Ai do

  before(:each) do
    @game = Game.new
    @ai = @game.ai
    @board = @game.board
    @human = @game.human
  end

  it 'makes a move on its own' do
    @ai.move(@board)
    expect(@ai.moves.count).to eql 1
  end

  it 'takes the middle spot if that spot is ever open' do
    @ai.move(@board)
    expect(@ai.moves).to include("M2")
  end

  it 'takes an opposite corner after player takes an edge on player first turn' do
    move = @ai.move(@board)
    @board.possible_moves.delete(move)
    move = @human.move("T2")
    @board.last_move = "T2"
    @ai.move(@board)
    expect(@ai.moves).to include("B1")
  end

  it 'takes the opposite corner after player takes a corner' do
    move = @ai.move(@board)
    @board.possible_moves.delete(move)
    move = @human.move("T1")
    @board.last_move = "T1"
    @ai.move(@board)
    expect(@ai.moves).to include("B3")
  end

  it 'blocks player wins' do
    move = @ai.move(@board)
    @board.possible_moves.delete(move)
    move = @board.add_move("T2", @human)
    @board.last_move = "T2"
    @board.possible_moves.delete("T2")
    move = @ai.move(@board)
    @board.possible_moves.delete(move)
    move = @board.add_move("T3", @human)
    @board.last_move = "T3"
    @board.possible_moves.delete("T3")
    @ai.move(@board)
    expect(@ai.moves).to include("T1")
  end

  it 'takes winning spots' do
    move = @ai.move(@board)
    @board.possible_moves.delete(move)

    move = @board.add_move("M1", @human)
    @board.last_move = "M1"
    @board.possible_moves.delete(move)

    move = @ai.move(@board)
    @board.possible_moves.delete(move)

    move = @board.add_move("B1", @human)
    @board.last_move = "B1"
    @board.possible_moves.delete("B1")

    move = @ai.move(@board)
    @board.possible_moves.delete(move)

    move = @board.add_move("T2", @human)
    @board.last_move = "T2"
    @board.possible_moves.delete(move)

    move = @ai.move(@board)
    expect(@game.winner).to eql @ai
  end


end
