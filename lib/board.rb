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

      current_value = @board[row_index][col_index]
      return false if current_value.is_a?(String)

      if row_index <= 4
        new_row = row_index + 1
        bottom_value = @board[new_row][col_index]
        return false if bottom_value.is_a?(Integer)
      end
      
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