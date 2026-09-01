require_relative 'board'
require_relative 'player'

class Game
  def initialize(
    board = Board.new,
    player_one = Player.new("X"),
    player_two = Player.new("O")
    )
    @board = board
    @player_one = player_one
    @player_two = player_two
    @current_player = @player_one
  end

  def test
    @board.show_board
  end

  def check
    test
  end
  
end