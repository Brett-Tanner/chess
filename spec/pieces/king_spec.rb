# frozen_string_literal: true

require './lib/king.rb'

describe King do
  subject(:king) {described_class.new("black")}

  before do
    allow(king).to receive(:puts)
  end
  
  describe "#legal?" do
    let(:board) {Array.new}

    context "When the move is legal" do
      it "moves one space up" do
        start = [4, 4]
        dest = [5, 4]
        legal = king.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves one space down" do
        start = [4, 4]
        dest = [3, 4]
        legal = king.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves one space right" do
        start = [4, 4]
        dest = [4, 5]
        legal = king.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves one space left" do
        start = [4, 4]
        dest = [4, 3]
        legal = king.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves one space down-left" do
        start = [4, 4]
        dest = [3, 3]
        legal = king.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves one space up-left" do
        start = [4, 4]
        dest = [5, 3]
        legal = king.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves one space down-right" do
        start = [4, 4]
        dest = [3, 5]
        legal = king.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves one space up-right" do
        start = [4, 4]
        dest = [5, 5]
        legal = king.legal?(start, dest, board)
        expect(legal).to be true
      end
    end

    context "When the move isn't legal" do
      it "won't move two spaces" do
        start = [4, 4]
        dest = [4, 6]
        legal = king.legal?(start, dest, board)
        expect(legal).to be false
      end
    end
  end
end