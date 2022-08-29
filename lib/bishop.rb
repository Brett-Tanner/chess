# frozen_string_literal: true

require './lib/piece.rb'

class Bishop < Piece
  def initialize(color)
    @symbol = "♗" if color == "white"
    @symbol = "♝" if color == "black"
    @color = color
  end
end