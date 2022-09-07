# frozen_string_literal: true

require './lib/bishop.rb'

describe Bishop do
  subject(:bishop) {described_class.new("white")}

  before do
    allow(bishop).to receive(:puts)
  end

  describe "#legal?" do
    let(:board) {Array.new}

    context "When the move is legal" do
      it "moves diagonally left & up" do
        start = [2, 2]
        dest = [1, 1]
        legal = bishop.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves diagonally left & down" do
        start = [1, 8]
        dest = [8, 1]
        legal = bishop.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves diagonally right & up" do
        start = [4, 4]
        dest = [8, 8]
        legal = bishop.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves diagonally right & down" do
        start = [3, 4]
        dest = [1, 6]
        legal = bishop.legal?(start, dest, board)
        expect(legal).to be true
      end
    end

    context "When the move isn't legal" do
      let(:board) {Array.new}

      it "doesn't move vertically" do
        start = [4, 4]
        dest = [5, 4]
        legal = bishop.legal?(start, dest, board)
        expect(legal).to be false
      end

      it "doesn't move horizontally" do
        start = [4, 4]
        dest = [4, 3]
        legal = bishop.legal?(start, dest, board)
        expect(legal).to be false
      end
    end
  end

  describe "#clear_path?" do
    
  end
end