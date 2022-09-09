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

  describe "#clear_path?" do
    let(:board) {
      board = Hash.new
      (1..8).each {|i| board[i] = [" ", " ", " ", " ", " ", " ", " ", " "]}
      board[4][3] = double('white_piece', color: "white")
      board[3][3] = double('white_piece', color: "white")
      board[5][3] = double('white_piece', color: "white")
      board[5][4] = double('white_piece', color: "white")
      board
    }

    context "when the path is clear" do
      it "moves diagonally" do
        start = [4, 4]
        dest = [7, 7]
        clear_path = queen.clear_path?(start, dest, board)
        expect(clear_path).to be true
      end

      it "moves vertically" do
        start = [4, 4]
        dest = [1, 4]
        clear_path = queen.clear_path?(start, dest, board)
        expect(clear_path).to be true
      end

      it "moves horizontally" do
        start = [4, 4]
        dest = [4, 8]
        clear_path = queen.clear_path?(start, dest, board)
        expect(clear_path).to be true
      end

      it "can take a piece next to it" do
        start = [4, 4]
        dest = [4, 3]
        clear_path = queen.clear_path?(start, dest, board)
        expect(clear_path).to be true
      end
    end

    context "when the path isn't clear" do
      it "doesn't move diagonally" do
        start = [4, 4]
        dest = [1, 1]
        clear_path = queen.clear_path?(start, dest, board)
        expect(clear_path).to be false
      end

      it "doesn't move vertically" do
        start = [4, 4]
        dest = [8, 4]
        clear_path = queen.clear_path?(start, dest, board)
        expect(clear_path).to be false
      end

      it "doesn't move horizontally" do
        start = [4, 4]
        dest = [4, 1]
        clear_path = queen.clear_path?(start, dest, board)
        expect(clear_path).to be false
      end
    end
  end
end