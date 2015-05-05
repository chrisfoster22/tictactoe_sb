require 'rspec'
require_relative '../game'

RSpec.describe Game do
  it 'takes a move' do
    game = Game.new
    game.move("M2")
    expect(game.moves).to eql ["M2"]
  end

end
