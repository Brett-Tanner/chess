# frozen_string_literal: true

require './lib/pawn.rb'

describe Pawn do
  subject(:b_pawn) {described_class.new("black")}
  subject(:w_pawn) {described_class.new("white")}

  before :each do
    allow(b_pawn).to receive(:puts)
    allow(w_pawn).to receive(:puts)
  end

  describe "#legal?" do
    context "When pawn is on its starting row" do
      let(:board) {Array.new(9) {Array.new(9)}}

      context "when black moves one space" do
        it "returns true" do
          start = [7, 5]
          dest = [6, 5]
          legal = b_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end
      end

      context "when white moves one space" do
        it "returns true" do
          start = [2, 2]
          dest = [3, 2]
          legal = w_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end
      end

      context "when black moves two spaces" do
        it "returns true" do
          start = [7, 8]
          dest = [5, 8]
          legal = b_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end
      end

      context "when white moves two spaces" do
        it "returns true" do
          start = [2, 7]
          dest = [4, 7]
          legal = w_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end
      end
    end

    context "When pawn is on any other row" do
      let(:board) {Array.new(9) {Array.new(9)}}

      context "when black moves one space" do
        it "returns true" do
          start = [4, 5]
          dest = [3, 5]
          legal = b_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end
      end

      context "when black moves two spaces" do
        it "returns false" do
          start = [4, 8]
          dest = [2, 8]
          legal = b_pawn.legal?(start, dest, board)
          expect(legal).to be false
        end
      end

      context "when white moves one space" do
        it "returns true" do
          start = [6, 2]
          dest = [7, 2]
          legal = w_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end
      end

      context "when white moves two spaces" do
        it "returns false" do
          start = [6, 7]
          dest = [8, 7]
          legal = w_pawn.legal?(start, dest, board)
          expect(legal).to be false
        end
      end
    end

    context "When pawn tries to move diagonally" do

      context "and target space is occupied by an enemy piece" do
        let(:board) {
          white_top = Array.new(9) {Array.new(9, double('white_piece', color: "white"))}
          black_bot = Array.new(9) {Array.new(9, double('white_piece', color: "white"))}
          white_top.concat(black_bot)
        }

        it "white returns true" do #####
          start = [2, 2]
          dest = [3, 3]
          legal = w_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end

        it "black returns true" do #####
          start = [7, 7]
          dest = [6, 8]
          legal = b_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end
      end

      context "and target space is occupied by a friendly piece" do
        xit "returns false" do
          
        end
      end

      context "and target space is unoccupied" do
        xit "returns false" do
          
        end
      end
    end
  end

  describe "#prune" do
    context "When the pawn moves one row" do
      xit "prunes that row" do
        
      end
    end

    context "When the pawn moves two rows" do
      xit "prunes both rows" do
        
      end
    end
  end
end