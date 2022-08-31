# frozen_string_literal: true

require './lib/state.rb'

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

    it "adds all 32 pieces to active pieces" do
      active = state.active_pieces
      length = active.length
      expect(length).to eql(32)
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
    let(:player) {double('player', name: "Brett", color: "White")}

    context "When input is out of bounds" do

      before do
        allow(state).to receive(:gets).and_return("a9 to b9", "a1 to h8")  
      end

      it "displays an error message" do
        error = "**Your coordinates are out of bounds**"
        expect(state).to receive(:puts).with(error).once
        state.move(player)
      end

      it "asks for new inputs" do
        message = "Brett, what's your move?"
        expect(state).to receive(:puts).with(message).twice
        state.move(player)
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
        State.new(Array.new(8, Array.new(9, occupied_space)).push(Array.new(9, unoccupied_space)))
      end

      before do
        allow(occupied_state).to receive(:gets).and_return("a1 to a8", "a1 to h8")
        allow(occupied_state).to receive(:puts)
      end
      
      it "displays an error message" do
        error = "**You can't take your own piece!**"
        expect(occupied_state).to receive(:puts).with(error).once
        occupied_state.move(player)
      end

      it "asks for new inputs" do
        message = "Brett, what's your move?"
        expect(occupied_state).to receive(:puts).with(message).twice
        occupied_state.move(player)
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

    context "When move is valid, nothing taken" do
      xit "changes the starting space" do
        
      end

      xit "changes the destination space" do
        
      end
      
      xit "pushes start and destination to move_list" do
        
      end

      xit "doesn't display any errors" do
        
      end

      xit "doesn't affect active piece list" do
        
      end
    end

    context "When a piece is taken" do
      xit "removes the piece from active pieces" do
        
      end
    end
  end

  describe "#save" do
    
  end
end