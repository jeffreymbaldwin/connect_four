class Board
  def initialize
    create_board
  end
  
  def show_board
    @board.each_with_index do |row, index|
      formatted_row = row.map do |element| 
        if element.is_a?(Integer)
          format("%02d", element)
        else 
          element * 2
        end
      end
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
    # row check
    @board.any? do |row|
      row.each_cons(4).any? do |four|
        return true if four.all? do |element|
          element == marker
        end  
      end
    end
    # column check
    @board.transpose.any? do |row|
      row.each_cons(4).any? do |four|
        return true if four.all? do |element|
          element == marker
        end
      end
    end
    # diagonal check
    @board.each_with_index do |row, row_index|
      row.each_with_index do |value, col_index |
        if value == marker

          check = diagonal_check(1, row_index, col_index, marker)
          return true if check
          check = diagonal_check(-1, row_index, col_index, marker)
          return true if check 
  
        end
      end
    end
    false
  end

  def draw? 
    @board.flatten.none? do |element|
      element.is_a?(Integer)
    end
  end

  private

  def diagonal_check(direction, vertical_index, horizontal_index, marker)
  vertical_end = vertical_index + 3
  horizontal_end = horizontal_index + direction * 3
    if vertical_end <= 5 && horizontal_end >= 0 && horizontal_end <= 6
      four_group = []
      current_row = vertical_index
      current_col = horizontal_index
      until four_group.length > 3
        four_group << @board[current_row][current_col]
        current_row += 1
        current_col += direction
      end
      four_group.all? { |element| element == marker }
    end
  end

  def create_board
    @board = Array.new(6) do |row_index|
      Array.new(7) do |col_index|
        (row_index * 7) + col_index + 1
      end
    end
  end

end  