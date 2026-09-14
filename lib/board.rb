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

  def winner?(marker)
    horizontal = @board.any? do |row|
      row.each_cons(4).any? do |four|
        four.all? do |element|
          element == marker
        end  
      end
    end

    vertical = @board.transpose.any? do |row|
      row.each_cons(4).any? do |four|
        four.all? do |element|
          element == marker
        end
      end
    end

    @board.each_with_index do |row, vertical_index|
      row.each_with_index do |value, horizontal_index |
        if value == marker
          vertical_end = vertical_index + 3
          horizontal_end = horizontal_index + 3
            if vertical_end <= 5 && horizontal_end <= 6
              four_group = []
              current_row = vertical_index
              current_col = horizontal_index
              until four_group.length > 3
                four_group << @board[current_row][current_col]
                current_row += 1
                current_col += 1
              end
              return true if four_group.all? { |element| element == marker }
            end

          vertical_end = vertical_index + 3
          horizontal_end = horizontal_index - 3
            if vertical_end <= 5 && horizontal_end >= 0
              four_group = []
              current_row = vertical_index
              current_col = horizontal_index
              until four_group.length > 3
                four_group << @board[current_row][current_col]
                current_row += 1
                current_col -= 1
              end
              return true if four_group.all? { |element| element == marker}
            end
        end
      end
    end

    
    if horizontal == true || vertical == true
      true
    else
      false
    end
    
  end

  # does value = marker?
  # if so then could we even get a 4-cell diagonal
  # if yes, then inspect value + 3 more cooridiantes and see if they all = marker
  # 
  #
  # Maybe until? Until vertical_index > vertical_index + 3
  #
  #or until array.length > 2 put the value in the array for these coordiantes? 
  # 
  #So trying to get each value from each cell when we know that we can. How to go through each. 
  #

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