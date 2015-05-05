require 'rspec'
require_relative '../game'

RSpec.describe Game do
  before(:each) do
    @game = Game.new
  end

  it 'takes a move' do
    @game.move("M2")
    expect(@game.moves).to eql ["M2"]
  end

  it 'has two players' do
    expect(@game.players.count).to eql 2
  end

  it 'has an AI player and a Human player' do
    expect(@game.players.first.class).to eql Ai
    expect(@game.players.last.class).to eql Player
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
  end

  it 'makes a move' do
    ai = @game.ai
    ai.move("M2")
    expect(ai.moves).to eql ["M2"]
  end

end
