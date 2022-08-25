# frozen_string_literal: true

require './lib/bishop.rb'
require './lib/castle.rb'
require './lib/king.rb'
require './lib/knight.rb'
require './lib/pawn.rb'
require './lib/queen.rb'

class Board
  def initialize
    @move_list = []
    @active_pieces = []
    @taken_pieces = []
  end

  def get_move(player)
    
  end

  def checkmate?
    
  end

  def save
    
  end
end