# frozen_string_literal: true

require './lib/piece.rb'

class Pawn < Piece
  def initialize(color)
    @symbol = "♙" if color == "white"
    @symbol = "♟" if color == "black"
    @color = color
  end

  def legal?(start, dest, board)
    s_row = start[0] 
    d_row = dest[0]
    s_col = start[1]
    d_col = dest[1]
    # immediately return true if it's moving one forward from anywhere or two forward from starting position 
    return true if standard_move?(s_row, s_col, d_row, d_col) || opening_move?(s_row, s_col, d_row, d_col)
    return true if valid_diag?(s_row, s_col, d_row, d_col, board)
    puts "**A pawn can't move like that!**"
    false
  end

  private

  def standard_move?(s_row, s_col, d_row, d_col)
    (d_row == s_row + 1 && d_col == s_col && @color == "white") || (d_row == s_row - 1 && d_col == s_col && @color == "black") 
  end

  def opening_move?(s_row, s_col, d_row, d_col)
    white_start = 2
    black_start = 7
    (s_row == white_start && d_row == white_start + 2 && s_col == d_col && @color == "white") || (s_row == black_start && d_row == black_start - 2 && s_col == d_col && @color == "black")
  end

  def valid_diag?(s_row, s_col, d_row, d_col, board)
    valid_squares = [[s_row + 1, s_col + 1], [s_row + 1, s_col - 1]] if @color == "white"
    valid_squares = [[s_row - 1, s_col + 1], [s_row - 1, s_col - 1]] if @color == "black"
    return false unless valid_squares.include?([d_row, d_col])
    return false if board[d_row, d_col] == " " || board[d_row, d_col].color == @color
    return true
  end
end