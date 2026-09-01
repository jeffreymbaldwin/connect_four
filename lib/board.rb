class Board
  def initialize
    create_board
  end
  
  def show_board
    @board.each_with_index do |row, index|
      formatted_row = row.map { |element| 
      if element.is_a?(Integer)
        format("%02d", element)
      else 
        element * 2
      end}
      puts formatted_row.join("  |  ")
      unless index == @board.length - 1
        puts "--------------------------------------------"
      end
  
    end
  end

  def update_board(position, marker)
      zero_based = position - 1
      row_index = zero_based / 7
      col_index = zero_based % 7

      @board[row_index][col_index] = marker
      true    
  end





#~~~~~~~~private methods below here ~~~~~~

private
  def create_board
    @board = Array.new(6) do |row_index|
      Array.new(7) do |col_index|
        (row_index * 7) + col_index + 1
      end
    end
  end
end