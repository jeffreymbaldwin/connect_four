require_relative "../lib/board"

RSpec.describe Board do
  describe "#initialize" do
    it "creates a 6 by 7 board" do
      board = Board.new
      actual_board = board.instance_variable_get(:@board)
      expect(actual_board.length).to eq(6)
      expect(actual_board[0].length).to eq(7)
    end

    it "numbers the board from 1 to 42" do
      board = Board.new
      actual_board = board.instance_variable_get(:@board)
      expect(actual_board[0][0]).to eq(1)
      expect(actual_board[5][6]).to eq(42)
    end
  end

  describe "#update_board" do  
    it "returns true when placing a marker on a valid spot on the bottom row (36-42)" do
      board = Board.new
      position = 36
      marker = "X"
      
      result = board.update_board(position, marker)

      expect(result).to eq(true)
    end    
  end

end