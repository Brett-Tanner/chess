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
      row_length = board[0].length 
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
    subject(:print_board) {described_class.new.print_board}

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
    let(:player) (double('player', name: "Brett", color: "White"))
    subject(:move) (described_class.new.move(player))

    context "When input is out of bounds" do
      it "displays an error message" do
        
      end

      it "asks for new inputs" do
        
      end
    end

    context "When the space is occupied by friendly piece" do
      it "displays an error message" do
        
      end

      it "asks for new inputs" do
        
      end
    end

    context "When the move is illegal" do
      it "displays an error" do
        
      end

      it "asks for new inputs" do
        
      end
    end
  end

  describe "#save" do
    
  end
end