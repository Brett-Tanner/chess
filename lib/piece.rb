# frozen_string_literal: true

# each piece contains - 
# its own adjaceny list as a class instance variable constant (@@)
# a live copy of the possible moves and a way to prune it
# its symbols to be printed
# its color

# TODO: use super for color and adjacency list

class Piece

  attr_accessor :symbol, :color
  
  def invalid_move?(start, dest, board)
    
  end
end