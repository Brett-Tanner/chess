# frozen_string_literal: true

require './lib/piece.rb'

class King < Piece
  def initialize(color, position)
    @symbol = "♔" if color == "white"
    @symbol = "♚" if color == "black"
    @position = position
  end
end