# frozen_string_literal: true

require './lib/piece.rb'

class Pawn < Piece
  def initialize(color)
    @symbol = "♙" if color == "White"
    @symbol = "♟" if color == "Black"
    @color = color
  end

  def legal?(start, dest, board, display = "y")
    s_row = start[0] 
    d_row = dest[0]
    s_col = start[1]
    d_col = dest[1]
    # immediately return true if it's moving one forward from anywhere or two forward from starting position 
    return true if standard_move?(s_row, s_col, d_row, d_col) || opening_move?(s_row, s_col, d_row, d_col)
    # check if there's an enemy piece to take, otherwise return false
    return true if valid_diag?(s_row, s_col, d_row, d_col, board)
    puts "A pawn can't move like that!" if display == "y"
    false
  end

  def clear_path?(start, dest, board)
    row_diff = dest[0] - start[0]
    col_diff = dest[1] - start[1]
    return true if row_diff == col_diff
    case row_diff
    when 1
      return true unless board[start[0] + 1][start[0]] != " "
    when 2
      return true unless board[start[0] + 1][start[0]] != " " || board[start[0] + 2][start[0]] != " "
    when -1
      return true unless board[start[0] - 1][start[0]] != " "
    when -2
      return true unless board[start[0] - 1][start[0]] != " " || board[start[0] - 2][start[0]] != " "
    else
      puts "That's not a valid move for a Pawn"
    end
    puts "There's a piece blocking your Pawn"
    false
  end

  private

  def standard_move?(s_row, s_col, d_row, d_col)
    (d_row == s_row + 1 && d_col == s_col && @color == "White") || (d_row == s_row - 1 && d_col == s_col && @color == "Black") 
  end

  def opening_move?(s_row, s_col, d_row, d_col)
    white_start = 2
    black_start = 7
    (s_row == white_start && d_row == white_start + 2 && s_col == d_col && @color == "White") || (s_row == black_start && d_row == black_start - 2 && s_col == d_col && @color == "Black")
  end

  def valid_diag?(s_row, s_col, d_row, d_col, board)
    valid_squares = [[s_row + 1, s_col + 1], [s_row + 1, s_col - 1]] if @color == "White"
    valid_squares = [[s_row - 1, s_col + 1], [s_row - 1, s_col - 1]] if @color == "Black"
    return false unless valid_squares.include?([d_row, d_col])
    return false if board[d_row][d_col] == " " || board[d_row][d_col].color == @color
    return true
  end
end