# frozen_string_literal: true

# each piece contains - 
# its own adjaceny list as a class instance variable constant (@@)
# a live copy of the possible moves and a way to prune it
# its symbols to be printed
# its color
# its location on the board (e.g. "\u265A"e5)

class Piece

  attr_accessor :symbol, :color
  
  def valid_move?(start, dest)
    
  end
end