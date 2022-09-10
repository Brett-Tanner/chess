# frozen_string_literal: true

require './lib/state.rb'
require './lib/king.rb'
require './lib/queen.rb'
require './lib/pawn.rb'

describe State do
  subject(:state) {described_class.new}

  before do
    allow(state).to receive(:puts)
    allow(state).to receive(:print)
  end

  describe "#create_board" do
    subject(:board) {described_class.new.board}

    it {is_expected.to be_an_instance_of Hash}

    it "is 9x9" do
      num_rows = board.length
      row_length = board[1].length 
      expect(num_rows).to eql(9)
      expect(row_length).to eql(9)
    end
  end

  describe "#print_board" do

      it "prints 9 lines" do
        expect(state).to receive(:puts).exactly(9).times
        state.print_board
      end

      it "prints 9 columns" do
        expect(state).to receive(:print).exactly(81).times
        state.print_board
      end
  end

  describe "#move" do
    let(:w_player) {double('player', name: "Brett", color: "White")}
    let(:b_player) {double('b_player', name: "Viktoria", color: "Black")}

    context "When input is out of bounds" do

      before do
        allow(state).to receive(:gets).and_return("a9 to b9", "b2 to d2")  
      end

      it "displays an error message" do
        error = "**Your coordinates are out of bounds**"
        expect(state).to receive(:puts).with(error).once
        state.move(w_player)
      end

      it "asks for new inputs" do
        message = "Brett, what's your move?"
        expect(state).to receive(:puts).with(message).twice
        state.move(w_player)
      end
    end

    context "When the space is occupied by friendly piece" do
      let(:occupied_space) {
        double('occupied', class: "Rook", color: "White", invalid_move?: false)
      }
      let(:unoccupied_space) {
        double('unoccupied', class: "Rook", color: "Black", invalid_move?: false)
      }

      subject(:occupied_state) do 
        described_class.new(Array.new(8, Array.new(9, occupied_space)).push(Array.new(9, unoccupied_space)))
      end

      before do
        allow(occupied_state).to receive(:gets).and_return("a1 to a8", "a1 to h8")
      end
      
      xit "displays an error" do
        error = "**You can't take your own piece!**"
        expect(occupied_state).to receive(:puts).with(error).once
        occupied_state.move(w_player)
      end

      xit "asks for new inputs" do
        message = "Brett, what's your move?"
        expect(occupied_state).to receive(:puts).with(message).twice
        occupied_state.move(w_player)
      end
    end

    context "When the player's King is in check" do
      let(:board) {
        board = Hash.new
        (1..8).each {|i| board[i] = [" ", " ", " ", " ", " ", " ", " ", " "]}
        board[4][4] = King.new("White")
        board[5][5] = Pawn.new("White")
        board[8][8] = Queen.new("Black")
        board
      }

      before do
        state.board = board
        allow(state).to receive(:gets).and_return("e5 to f5", "d4 to e4")
      end

      it "displays an error" do
        error = "**You can't move your king into check**"
        expect(state).to receive(:puts).with(error)
        state.move(w_player)
      end

      it "asks for new inputs" do
        message = "Brett, what's your move?"
        expect(state).to receive(:puts).with(message).twice
        state.move(w_player)
      end

      after :each do
        state.board = state.create_board
      end
    end

    context "When the piece can't move like that" do

      before do
        
      end

      xit "displays an error" do
        
      end

      xit "asks for new inputs" do
        
      end
    end

    context "When there are other pieces blocking the path" do
      
      before do
        
      end

      xit "displays an error" do
        
      end

      xit "asks for new inputs" do
        
      end
    end

    context "When move is valid, nothing taken" do

      before do
        allow(state).to receive(:gets).and_return("b7 to d7")
      end

      xit "changes the starting space" do
        original_contents = state.board[2][7]
        expect {state.move(w_player)}.to change {state.board[2][7]}.from(original_contents).to(" ")
      end

      xit "changes the destination space" do
        original_contents = state.board[4][7]
        new_contents = state.board[2][7]
        expect {state.move(w_player)}.to change {state.board[4][7]}.from(original_contents).to(new_contents)
      end
      
      xit "pushes start and destination to move_list" do
        state.move(w_player)
        last_move = state.instance_variable_get(:@move_list).last
        move = [[2, 7], [4, 7]]
        expect(last_move).to eq(move)
      end

      xit "doesn't display any errors" do
        boundary_error = "**Your coordinates are out of bounds**"
        friendly_error = "**You can't take your own piece!**"
        check_error = "**You can't move your king into check**"
        expect(state).not_to receive(:puts).with(boundary_error)
        expect(state).not_to receive(:puts).with(friendly_error)
        expect(state).not_to receive(:puts).with(check_error)
      end
    end
  end

  describe "#save" do
    let(:p1) {double("p1", name: "Brett")}
    let(:p2) {double("p2", name: "Viktoria")}
    let(:filename) {"./data/Brett_vs_Viktoria.yaml"}

    subject(:state_save) {described_class.new(["I'm a board!"], ["I'm a move list!"], p1, p2)}

    it "creates a .yaml file using player names" do
      state_save.save
      exists = File.exist?(filename)
      expect(exists).to be true
      File.delete(filename)
    end
  end
end