# frozen_string_literal: true

require './lib/rook.rb'

describe Rook do
  subject(:rook) {described_class.new("white")}

  before do
    allow(rook).to receive(:puts)
  end

  describe "#legal?" do
    let(:board) {Array.new}

    context "When the move is legal" do
      it "moves unlimited spaces horizontally" do
        start = [1, 1]
        dest = [1, 8]
        legal = rook.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves unlimited spaces vertically" do
        start = [1, 1]
        dest = [8, 1]
        legal = rook.legal?(start, dest, board)
        expect(legal).to be true
      end
    end

    context "When the move isn't legal" do
      it "doesn't move in an L-shape" do
        start = [4, 4]
        dest = [6, 3]
        legal = rook.legal?(start, dest, board)
        expect(legal).to be false
      end

      it "doesn't move to a random space" do
        start = [4, 4]
        dest = [7, 8]
        legal = rook.legal?(start, dest, board)
        expect(legal).to be false
      end

      it "doesn't move diagonally" do
        start = [4, 4]
        dest = [5, 5]
        legal = rook.legal?(start, dest, board)
        expect(legal).to be false
      end
    end
  end
end