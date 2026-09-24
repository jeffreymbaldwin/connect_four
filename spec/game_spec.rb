require_relative "../lib/game"

RSpec.describe Game do
  describe '#play' do
    let(:board) { instance_double(Board) }
    let(:player_one) { instance_double(Player, marker: "X") }
    let(:player_two) { instance_double(Player, marker: "Y") }
    subject(:game) { described_class.new(board, player_one, player_two) }

    it "ends the loop when there is a winner" do
      allow(board).to receive(:winner?).and_return(true)
      expect(game).to receive(:turn).once
      game.play
    end

    it "ends the loop when there is a draw" do
      allow(board).to receive(:winner?).and_return(false)
      allow(board).to receive(:draw?).and_return(true)
      expect(game).to receive(:turn).once
      game.play
    end

    it "switches players and loops when there is no winner nor draw " do
      allow(game).to receive(:turn)
      allow(board).to receive(:winner?).and_return(false,true)
      allow(board).to receive(:draw?).and_return(false)
      expect(game).to receive(:switch_player)
      game.play  
    end

    it " changes current_player from player_one to player_two and player_two to player_one" do
      expect { game.switch_player }.to change { game.instance_variable_get(:@current_player) }.from(player_one).to(player_two)
      expect { game.switch_player }.to change { game.instance_variable_get(:@current_player) }.from(player_two).to(player_one)
    end

  end

  describe "#turn" do 
    let(:board) { instance_double(Board) }
    let(:player_one) { instance_double(Player, marker: "X") }
    let(:player_two) { instance_double(Player, marker: "O") }
    subject(:game) {described_class.new(board, player_one, player_two) }
    it "prompts for user input once then finishes when the board accepts the user's input" do 
      allow(board).to receive(:update_board).and_return(true)
      allow(board).to receive(:show_board)
      expect(game).to receive(:ask_for_position).once.and_return(13)
      game.turn
    end

    it "asks again when the board rejects the position" do
      allow(board).to receive(:update_board).and_return(false, true)
      allow(board).to receive(:show_board)
      expect(game).to receive(:ask_for_position).twice.and_return(21,43)
      game.turn
    end
  end

  describe "#ask_for_position" do
    subject(:game) { described_class.new }
    it "returns an integer when the input is valid" do
      allow(game).to receive(:gets).and_return("42\n")
      result = game.ask_for_position
      expect(result).to eq(42)
    end
    it "repromps for a new input when the input is invalid until the new input is valid" do
      allow(game).to receive(:gets).and_return("6000\n", "41\n")
      result = game.ask_for_position
      expect(result).to eq(41)
    end 
  end
end