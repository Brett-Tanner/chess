# frozen_string_literal: true

require './lib/piece.rb'

class Pawn < Piece
  def initialize(color)
    @symbol = "♙" if color == "white"
    @symbol = "♟" if color == "black"
    @color = color
  end
end