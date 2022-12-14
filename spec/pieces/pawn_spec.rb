# frozen_string_literal: true

require './lib/pawn.rb'

describe Pawn do
  subject(:b_pawn) {described_class.new("Black")}
  subject(:w_pawn) {described_class.new("White")}

  before :each do
    allow(b_pawn).to receive(:puts)
    allow(w_pawn).to receive(:puts)
  end

  describe "#legal?" do
    context "When pawn is on its starting row" do
      let(:board) {Array.new(9) {Array.new(9)}}

      context "when pawn moves one space" do
        it "black returns true" do
          start = [7, 5]
          dest = [6, 5]
          legal = b_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end

        it "white returns true" do
          start = [2, 2]
          dest = [3, 2]
          legal = w_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end
      end

      context "when pawn moves two spaces" do
        it "black returns true" do
          start = [7, 8]
          dest = [5, 8]
          legal = b_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end

        it "white returns true" do
          start = [2, 7]
          dest = [4, 7]
          legal = w_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end
      end
    end

    context "When pawn is on any other row" do
      let(:board) {Array.new(9) {Array.new(9)}}

      context "when pawn moves one space" do
        it "black returns true" do
          start = [4, 5]
          dest = [3, 5]
          legal = b_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end

        it "white returns true" do
          start = [6, 2]
          dest = [7, 2]
          legal = w_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end
      end

      context "when pawn moves two spaces" do
        it "black returns false" do
          start = [4, 8]
          dest = [2, 8]
          legal = b_pawn.legal?(start, dest, board)
          expect(legal).to be false
        end

        it "white returns false" do
          start = [6, 7]
          dest = [8, 7]
          legal = w_pawn.legal?(start, dest, board)
          expect(legal).to be false
        end
      end
    end

    context "When pawn tries to move diagonally" do

      let(:board) {
        black_top = Array.new(3) {Array.new(9, double('black_piece', color: "Black"))}
        empty_mid = Array.new(3) {Array.new(9, " ")}
        white_bot = Array.new(3) {Array.new(9, double('white_piece', color: "White"))}
        black_top.concat(empty_mid).concat(white_bot)
      }
      
      context "and target space is occupied by an enemy piece" do
        

        it "white returns true" do
          start = [1, 1]
          dest = [2, 2]
          legal = w_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end

        it "black returns true" do
          start = [8, 7]
          dest = [7, 8]
          legal = b_pawn.legal?(start, dest, board)
          expect(legal).to be true
        end
      end

      context "and target space is occupied by a friendly piece" do
        it "white returns false" do
          start = [7, 6]
          dest = [8, 5]
          legal = w_pawn.legal?(start, dest, board)
          expect(legal).to be false
        end

        it "black returns false" do
          start = [2, 2]
          dest = [1, 1]
          legal = b_pawn.legal?(start, dest, board)
          expect(legal).to be false
        end
      end

      context "and target space is unoccupied" do
        it "white returns false" do
          start = [2, 3]
          dest = [3, 2]
          legal = w_pawn.legal?(start, dest, board)
          expect(legal).to be false
        end

        it "black returns false" do
          start = [6, 4]
          dest = [5, 5]
          legal = b_pawn.legal?(start, dest, board)
          expect(legal).to be false
        end
      end
    end
  end

  describe "#clear_path?" do
    let(:board) {
      board = Hash.new
      (1..8).each {|i| board[i] = [" ", " ", " ", " ", " ", " ", " ", " "]}
      board[5][4] = double('white_piece', color: "White")
      board[3][3] = double('white_piece', color: "White")
      board
    }

    context "When path is clear" do
      it "moves one space forward" do
        start = [4, 4]
        dest = [3, 4]
        clear = b_pawn.clear_path?(start, dest, board)
        expect(clear).to be true
      end

      it "moves two spaces forward" do
        start = [4, 4]
        dest = [2, 4]
        clear = b_pawn.clear_path?(start, dest, board)
        expect(clear).to be true
      end
    end

    context "When path is blocked" do
      it "can take diagonally" do
        start = [4, 4]
        dest = [3, 3]
        clear = w_pawn.clear_path?(start, dest, board)
        expect(clear).to be true
      end

      it "can't move one space forward" do
        start = [4, 4]
        dest = [5, 4]
        clear = w_pawn.clear_path?(start, dest, board)
        expect(clear).to be false
      end

      it "can't move two spaces forward" do
        start = [4, 4]
        dest = [6, 4]
        clear = w_pawn.clear_path?(start, dest, board)
        expect(clear).to be false
      end
    end
  end
end