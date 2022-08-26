# frozen_string_literal: true

require './lib/piece.rb'

class King < Piece
  def initialize(color)
    @symbol = "♔" if color == "white"
    @symbol = "♚" if color == "black"
  end
end