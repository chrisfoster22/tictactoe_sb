require 'rspec'
require_relative '../game'

RSpec.describe Game do

  it 'takes a move' do
    game = Game.new
    game.move("M2")
    expect(game.moves).to eql ["M2"]
  end

  it 'has two players' do
    game = Game.new
    expect(game.players.count).to eql 2
  end

  it 'has an AI player and a Human player' do
    game = Game.new
    expect(game.players.first.class).to eql Ai
    expect(game.players.last.class).to eql Player
  end

end

RSpec.describe Player do

  it 'makes a move' do
    game = Game.new
    player = game.human
    player.move("M2")
    expect(player.moves).to eql ["M2"]
  end

end

RSpec.describe Ai do

  it 'makes a move' do
    game = Game.new
    ai = game.ai
    ai.move("M2")
    expect(ai.moves).to eql ["M2"]
  end

end
