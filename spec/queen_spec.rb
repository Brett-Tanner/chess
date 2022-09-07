# frozen_string_literal: true

require './lib/queen.rb'

describe Queen do
  subject(:queen) {described_class.new("black")}

  before do
    allow(queen).to receive(:puts)
  end

  describe "#legal?" do
    let(:board) {Array.new}

    context "When the move is legal" do
      it "moves unlimited spaces horizontally" do
        start = [4, 4]
        dest = [4, 8]
        legal = queen.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves unlimited spaces vertically" do
        start = [4, 4]
        dest = [1, 4]
        legal = queen.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves unlimited spaces diagonally left-up" do
        start = [4, 4]
        dest = [1, 1]
        legal = queen.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves unlimited spaces diagonally right-up" do
        start = [4, 4]
        dest = [1, 7]
        legal = queen.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves unlimited spaces diagonally left-down" do
        start = [4, 4]
        dest = [1, 1]
        legal = queen.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves unlimited spaces diagonally right-down" do
        start = [4, 4]
        dest = [1, 7]
        legal = queen.legal?(start, dest, board)
        expect(legal).to be true
      end
    end

    context "When the move isn't legal" do
      it "doesn't move in an L-shape" do
        start = [4, 4]
        dest = [6, 3]
        legal = queen.legal?(start, dest, board)
        expect(legal).to be false
      end

      it "doesn't move to a random space" do
        start = [4, 4]
        dest = [7, 8]
        legal = queen.legal?(start, dest, board)
        expect(legal).to be false
      end
    end
  end
end