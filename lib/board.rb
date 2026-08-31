class Board
  def initialize
    create_board
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