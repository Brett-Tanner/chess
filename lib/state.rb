# frozen_string_literal: true

require './lib/bishop.rb'
require './lib/rook.rb'
require './lib/king.rb'
require './lib/knight.rb'
require './lib/pawn.rb'
require './lib/queen.rb'

# creates itself as an 8x8 grid of alternating black/white square, with pieces in their starting positions and white at the bottom
# has active/taken pieces list of piece objects
# tracks white and black players
# keeps a list of all moves made
# has get_move method which translates letters to equiv numbers
# rejects moves that hit a friendly space or are invalid

class State
  def initialize
    @move_list = []
    @active_pieces = []
    @taken_pieces = []
  end

  def get_move(player)
    puts "#{player}, what's your move?"
  end

  def checkmate?
    
  end

  def save
    
  end
end