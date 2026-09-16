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
  
  def start
    @board.show_board
    play
  end

  def play 
    loop do
      puts "It's #{@current_player.marker}'s turn."
      turn
      if @board.winner?(@current_player.marker)
        break      
      elsif @board.draw?
        break
      else
      switch_player
      end
    end
  end

  def turn 
    
  end

  def switch_player
    @current_player = (@current_player == @player_one) ? @player_two : @player_one
  end
end