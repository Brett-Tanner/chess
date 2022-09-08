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
    let(:board) {
      board = Hash.new
      8.times {|i| board[8 - i] = [" ", " ", " ", " ", " ", " ", " ", " "]}
      board[4][3] = double('white_piece', color: "white")
      board[3][3] = double('white_piece', color: "white")
      board[5][3] = double('white_piece', color: "white")
      board[5][4] = double('white_piece', color: "white")
      board
    }

    context "when the path is clear" do
      it "moves diagonally" do
        start = [4, 4]
        dest = [3, 3]
        clear_path = bishop.clear_path?(start, dest, board)
        expect(clear_path).to be true
      end
    end

    context "when the path isn't clear" do
      it "doesn't move diagonally" do
        start = [4, 4]
        dest = [5, 5]
        clear_path = bishop.clear_path?(start, dest, board)
        expect(clear_path).to be false
      end
    end
  end
end