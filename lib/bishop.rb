# frozen_string_literal: true

require './lib/piece.rb'

class Bishop < Piece
  def initialize(color)
    @symbol = "♗" if color == "white"
    @symbol = "♝" if color == "black"
    @color = color
    @legal_moves = POSSIBLE_MOVES.dup
  end

  private

  def create_list
    list = Hash.new
    valid_coord = Array.new(9) {|i| i}
    valid_coord.repeated_permutation(2) {|permutation| list[permutation] = nil}
    offsets = bishop_offsets()
    list.each do |k, v| 
      next if k[0] < 1 || k[0] > 8 || k[1] < 1 || k[1] > 8
      list[k] = valid_moves(k, offsets)
    end
    list.compact
  end

  def valid_moves(start, bishop_offsets)
    valid_ends = bishop_offsets.map do |offset|
        row = start[0] + offset[0]
        col = start[1] + offset[1] 
        next if row < 1 || row > 8 || col < 1 || col > 8
        [row, col]
    end
    valid_ends.compact
  end

  def bishop_offsets
    offsets = [] 
    (1..8).each do |i|
      offsets << [i, i]
      offsets << [i, -i]
      offsets << [-i, i]
      offsets << [-i, -i]
    end
    offsets
  end

  POSSIBLE_MOVES = {
    [1, 1] => [[2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [8, 8]],
    [1, 2] => [[2, 3], [2, 1], [3, 4], [4, 5], [5, 6], [6, 7], [7, 8]],
    [1, 3] => [[2, 4], [2, 2], [3, 5], [3, 1], [4, 6], [5, 7], [6, 8]],
    [1, 4] => [[2, 5], [2, 3], [3, 6], [3, 2], [4, 7], [4, 1], [5, 8]],
    [1, 5] => [[2, 6], [2, 4], [3, 7], [3, 3], [4, 8], [4, 2], [5, 1]],
    [1, 6] => [[2, 7], [2, 5], [3, 8], [3, 4], [4, 3], [5, 2], [6, 1]],
    [1, 7] => [[2, 8], [2, 6], [3, 5], [4, 4], [5, 3], [6, 2], [7, 1]],
    [1, 8] => [[2, 7], [3, 6], [4, 5], [5, 4], [6, 3], [7, 2], [8, 1]],
    [2, 1] => [[3, 2], [1, 2], [4, 3], [5, 4], [6, 5], [7, 6], [8, 7]],
    [2, 2] => [[3, 3], [3, 1], [1, 3], [1, 1], [4, 4], [5, 5], [6, 6], [7, 7], [8, 8]],
    [2, 3] => [[3, 4], [3, 2], [1, 4], [1, 2], [4, 5], [4, 1], [5, 6], [6, 7], [7, 8]],
    [2, 4] => [[3, 5], [3, 3], [1, 5], [1, 3], [4, 6], [4, 2], [5, 7], [5, 1], [6, 8]],
    [2, 5] => [[3, 6], [3, 4], [1, 6], [1, 4], [4, 7], [4, 3], [5, 8], [5, 2], [6, 1]],
    [2, 6] => [[3, 7], [3, 5], [1, 7], [1, 5], [4, 8], [4, 4], [5, 3], [6, 2], [7, 1]],
    [2, 7] => [[3, 8], [3, 6], [1, 8], [1, 6], [4, 5], [5, 4], [6, 3], [7, 2], [8, 1]],
    [2, 8] => [[3, 7], [1, 7], [4, 6], [5, 5], [6, 4], [7, 3], [8, 2]],
    [3, 1] => [[4, 2], [2, 2], [5, 3], [1, 3], [6, 4], [7, 5], [8, 6]],
    [3, 2] => [[4, 3], [4, 1], [2, 3], [2, 1], [5, 4], [1, 4], [6, 5], [7, 6], [8, 7]],
    [3, 3] => [[4, 4], [4, 2], [2, 4], [2, 2], [5, 5], [5, 1], [1, 5], [1, 1], [6, 6], [7, 7], [8, 8]],
    [3, 4] => [[4, 5], [4, 3], [2, 5], [2, 3], [5, 6], [5, 2], [1, 6], [1, 2], [6, 7], [6, 1], [7, 8]],
    [3, 5] => [[4, 6], [4, 4], [2, 6], [2, 4], [5, 7], [5, 3], [1, 7], [1, 3], [6, 8], [6, 2], [7, 1]],
    [3, 6] => [[4, 7], [4, 5], [2, 7], [2, 5], [5, 8], [5, 4], [1, 8], [1, 4], [6, 3], [7, 2], [8, 1]],
    [3, 7] => [[4, 8], [4, 6], [2, 8], [2, 6], [5, 5], [1, 5], [6, 4], [7, 3], [8, 2]],
    [3, 8] => [[4, 7], [2, 7], [5, 6], [1, 6], [6, 5], [7, 4], [8, 3]],
    [4, 1] => [[5, 2], [3, 2], [6, 3], [2, 3], [7, 4], [1, 4], [8, 5]],
    [4, 2] => [[5, 3], [5, 1], [3, 3], [3, 1], [6, 4], [2, 4], [7, 5], [1, 5], [8, 6]],
    [4, 3] => [[5, 4], [5, 2], [3, 4], [3, 2], [6, 5], [6, 1], [2, 5], [2, 1], [7, 6], [1, 6], [8, 7]],
    [4, 4] => [[5, 5], [5, 3], [3, 5], [3, 3], [6, 6], [6, 2], [2, 6], [2, 2], [7, 7], [7, 1], [1, 7], [1, 1], [8, 8]],
    [4, 5] => [[5, 6], [5, 4], [3, 6], [3, 4], [6, 7], [6, 3], [2, 7], [2, 3], [7, 8], [7, 2], [1, 8], [1, 2], [8, 1]],
    [4, 6] => [[5, 7], [5, 5], [3, 7], [3, 5], [6, 8], [6, 4], [2, 8], [2, 4], [7, 3], [1, 3], [8, 2]],
    [4, 7] => [[5, 8], [5, 6], [3, 8], [3, 6], [6, 5], [2, 5], [7, 4], [1, 4], [8, 3]],
    [4, 8] => [[5, 7], [3, 7], [6, 6], [2, 6], [7, 5], [1, 5], [8, 4]],
    [5, 1] => [[6, 2], [4, 2], [7, 3], [3, 3], [8, 4], [2, 4], [1, 5]],
    [5, 2] => [[6, 3], [6, 1], [4, 3], [4, 1], [7, 4], [3, 4], [8, 5], [2, 5], [1, 6]],
    [5, 3] => [[6, 4], [6, 2], [4, 4], [4, 2], [7, 5], [7, 1], [3, 5], [3, 1], [8, 6], [2, 6], [1, 7]],
    [5, 4] => [[6, 5], [6, 3], [4, 5], [4, 3], [7, 6], [7, 2], [3, 6], [3, 2], [8, 7], [8, 1], [2, 7], [2, 1], [1, 8]],
    [5, 5] => [[6, 6], [6, 4], [4, 6], [4, 4], [7, 7], [7, 3], [3, 7], [3, 3], [8, 8], [8, 2], [2, 8], [2, 2], [1, 1]],
    [5, 6] => [[6, 7], [6, 5], [4, 7], [4, 5], [7, 8], [7, 4], [3, 8], [3, 4], [8, 3], [2, 3], [1, 2]],
    [5, 7] => [[6, 8], [6, 6], [4, 8], [4, 6], [7, 5], [3, 5], [8, 4], [2, 4], [1, 3]],
    [5, 8] => [[6, 7], [4, 7], [7, 6], [3, 6], [8, 5], [2, 5], [1, 4]],
    [6, 1] => [[7, 2], [5, 2], [8, 3], [4, 3], [3, 4], [2, 5], [1, 6]],
    [6, 2] => [[7, 3], [7, 1], [5, 3], [5, 1], [8, 4], [4, 4], [3, 5], [2, 6], [1, 7]],
    [6, 3] => [[7, 4], [7, 2], [5, 4], [5, 2], [8, 5], [8, 1], [4, 5], [4, 1], [3, 6], [2, 7], [1, 8]],
    [6, 4] => [[7, 5], [7, 3], [5, 5], [5, 3], [8, 6], [8, 2], [4, 6], [4, 2], [3, 7], [3, 1], [2, 8]],
    [6, 5] => [[7, 6], [7, 4], [5, 6], [5, 4], [8, 7], [8, 3], [4, 7], [4, 3], [3, 8], [3, 2], [2, 1]],
    [6, 6] => [[7, 7], [7, 5], [5, 7], [5, 5], [8, 8], [8, 4], [4, 8], [4, 4], [3, 3], [2, 2], [1, 1]],
    [6, 7] => [[7, 8], [7, 6], [5, 8], [5, 6], [8, 5], [4, 5], [3, 4], [2, 3], [1, 2]],
    [6, 8] => [[7, 7], [5, 7], [8, 6], [4, 6], [3, 5], [2, 4], [1, 3]],
    [7, 1] => [[8, 2], [6, 2], [5, 3], [4, 4], [3, 5], [2, 6], [1, 7]],
    [7, 2] => [[8, 3], [8, 1], [6, 3], [6, 1], [5, 4], [4, 5], [3, 6], [2, 7], [1, 8]],
    [7, 3] => [[8, 4], [8, 2], [6, 4], [6, 2], [5, 5], [5, 1], [4, 6], [3, 7], [2, 8]],
    [7, 4] => [[8, 5], [8, 3], [6, 5], [6, 3], [5, 6], [5, 2], [4, 7], [4, 1], [3, 8]],
    [7, 5] => [[8, 6], [8, 4], [6, 6], [6, 4], [5, 7], [5, 3], [4, 8], [4, 2], [3, 1]],
    [7, 6] => [[8, 7], [8, 5], [6, 7], [6, 5], [5, 8], [5, 4], [4, 3], [3, 2], [2, 1]],
    [7, 7] => [[8, 8], [8, 6], [6, 8], [6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1]],
    [7, 8] => [[8, 7], [6, 7], [5, 6], [4, 5], [3, 4], [2, 3], [1, 2]],
    [8, 1] => [[7, 2], [6, 3], [5, 4], [4, 5], [3, 6], [2, 7], [1, 8]],
    [8, 2] => [[7, 3], [7, 1], [6, 4], [5, 5], [4, 6], [3, 7], [2, 8]],
    [8, 3] => [[7, 4], [7, 2], [6, 5], [6, 1], [5, 6], [4, 7], [3, 8]],
    [8, 4] => [[7, 5], [7, 3], [6, 6], [6, 2], [5, 7], [5, 1], [4, 8]],
    [8, 5] => [[7, 6], [7, 4], [6, 7], [6, 3], [5, 8], [5, 2], [4, 1]],
    [8, 6] => [[7, 7], [7, 5], [6, 8], [6, 4], [5, 3], [4, 2], [3, 1]],
    [8, 7] => [[7, 8], [7, 6], [6, 5], [5, 4], [4, 3], [3, 2], [2, 1]],
    [8, 8] => [[7, 7], [6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1]],
  }
end