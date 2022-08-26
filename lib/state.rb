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

  attr_accessor :board

  def initialize(board = create_board(), list = [], active = [], taken = [])
    @board = board
    @move_list = list
    @active_pieces = active
    @taken_pieces = taken
  end

  def create_board
    black_back_row = ["H", Rook.new("black"), Knight.new("black"), Bishop.new("black"), King.new("black"), Queen.new("black"), Bishop.new("black"), Knight.new("black"), Rook.new("black")]

    black_front_row = Array.new(8, Pawn.new("black")).unshift("G")
    white_front_row = Array.new(8, Pawn.new("white")).unshift("B")

    white_back_row = ["A", Rook.new("white"), Knight.new("white"), Bishop.new("white"), King.new("white"), Queen.new("white"), Bishop.new("white"), Knight.new("white"), Rook.new("white")]

    board = Hash.new
    board[:col_nums] = Array.new(9) {|i| i unless i == 0}.unshift(" ").compact
    board[:h] = black_back_row
    board[:g] = black_front_row
    board[:f] = Array.new(8, nil).unshift("F")
    board[:e] = Array.new(8, nil).unshift("E")
    board[:d] = Array.new(8, nil).unshift("D")
    board[:c] = Array.new(8, nil).unshift("C")
    board[:b] = white_front_row
    board[:a] = white_back_row

    board
  end

  def print_board
    
  end

  def get_move(player)
    puts "#{player}, what's your move?"
  end

  def checkmate?
    
  end

  def save
    
  end
end