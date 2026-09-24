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
        puts "#{@current_player.marker} is the winner!"
        break      
      elsif @board.draw?
        puts "This match ends in a draw."
        break
      else
      switch_player
      end
    end
  end

  def turn 
    puts "What number will you place your marker?"

    position = ask_for_position
    until @board.update_board(position, @current_player.marker)
      puts "This spot is already taken"
      position = ask_for_position
    end
    puts "Marker Placed!"
    @board.show_board

  end

  def ask_for_position
    puts "Please enter 2 numbers between 01 and 42"

    input = gets.chomp

    until input.match?(/^\d{2}$/) && input.to_i >= 1 && input.to_i <= 42
      puts "Invalid input. Check that there isn't a marker already there
and that there is a marker UNDER where you want to place yours."
      puts "Please enter 2 numbers between 01 and 42"
      input = gets.chomp
    end

    input.to_i
    
  end

  def switch_player
    @current_player = (@current_player == @player_one) ? @player_two : @player_one
  end
end


#winner logic