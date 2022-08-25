# frozen_string_literal: true

require "./lib/board.rb"

# each piece contains - 
# its own adjaceny list as a class instance variable constant (@@)
# a live copy of the possible moves and a way to prune it
# its symbols to be printed
# its color
# its location on the board (e.g. "\u265A"e5)

# BOARD - 
# TODO: I think board should be the one that requires all the pieces and stores active/taken piece lists
# creates itself as an 8x8 grid of alternating black/white square, with pieces in their starting positions and white at the bottom
# has an update board method taking start and destination coordinates
# rejects moves that hit a friendly space or are invalid

# GAME - 
# has active/taken pieces list of piece objects
# tracks white and black players
# keeps a list of all moves made

# asks for moves
# translates letter inputs to numbers before passing to board
# calls a board method to check if game is over after each move

class Game
  def initialize
    @black
    @white
    @move_list = []
  end
end