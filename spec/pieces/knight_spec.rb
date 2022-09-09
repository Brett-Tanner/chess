# frozen_string_literal: true

require './lib/knight.rb'

describe Knight do
  subject(:knight) {described_class.new("white")}

  describe "#legal?" do
    let(:board) {Array.new}

    before do
      allow(knight).to receive(:puts)
    end

    context "When the move is legal" do
      it "moves in a short L shape up left" do
        start = [4, 4]
        dest = [6, 3]
        legal = knight.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves in a short L shape up right" do
        start = [4, 4]
        dest = [6, 5]
        legal = knight.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves in a short L shape down left" do
        start = [4, 4]
        dest = [2, 3]
        legal = knight.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves in a short L shape down right" do
        start = [4, 4]
        dest = [2, 5]
        legal = knight.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves in a long L shape up left" do
        start = [4, 4]
        dest = [3, 6]
        legal = knight.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves in a long L shape up right" do
        start = [4, 4]
        dest = [5, 6]
        legal = knight.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves in a long L shape down left" do
        start = [4, 4]
        dest = [3, 2]
        legal = knight.legal?(start, dest, board)
        expect(legal).to be true
      end

      it "moves in a long L shape down right" do
        start = [4, 4]
        dest = [3, 6]
        legal = knight.legal?(start, dest, board)
        expect(legal).to be true
      end
    end

    context "When the move isn't legal" do
      it "doesn't move in a horizontal line" do
        start = [4, 4]
        dest = [4, 8]
        legal = knight.legal?(start, dest, board)
        expect(legal).to be false
      end

      it "doesn't move in a vertical line" do
        start = [4, 4]
        dest = [8, 4]
        legal = knight.legal?(start, dest, board)
        expect(legal).to be false
      end

      it "doesn't move diagonally" do
        start = [4, 4]
        dest = [8, 8]
        legal = knight.legal?(start, dest, board)
        expect(legal).to be false
      end
    end
  end

  describe "#clear_path?" do
    it {is_expected.to be true}
  end
end