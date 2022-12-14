# frozen_string_literal: true

class Piece

  attr_accessor :symbol, :color, :legal_moves
  
  def legal?(start, dest, board, display = "y")
    return true if @legal_moves[start].include?(dest)
    puts "A #{self.class} can't move like that!" if display == "y"
    false
  end

  def clear_path?(start, dest, board)
    path = find_path(start, dest)
    # if path is empty, or no spaces between start and dest return true
    return true if path.empty?
    return true if path.all? {|space| board[space[0]][space[1]] == " "}
    # if path has at least one piece in the way, displays an error and returns false
    puts "There's a piece blocking your #{self.class}!"
    false
  end

  private

  def find_path(start, dest)
    row_diff = dest[0] - start[0]
    col_diff = dest[1] - start[1]
    path = []

    if row_diff != 0 && col_diff == 0 # vertical movement
      row_diff.abs.times do |i|
        space = [start[0] + row_diff, start[1] + col_diff]
        row_diff -= 1 if row_diff > 0
        row_diff += 1 if row_diff < 0
        next if space == dest || space == start
        path << space
      end
    elsif row_diff == 0 && col_diff != 0 # horizontal movement
      col_diff.abs.times do |i|
        space = [start[0], start[1] + col_diff]
        col_diff -= 1 if col_diff > 0
        col_diff += 1 if col_diff < 0
        next if space == dest || space == start
        path << space
      end
    elsif row_diff.abs == col_diff.abs # diagonal movement
      row_diff.abs.times do |i|
        space = [start[0] + row_diff, start[1] + col_diff]
        row_diff -= 1 if row_diff > 0
        row_diff += 1 if row_diff < 0
        col_diff -= 1 if col_diff > 0
        col_diff += 1 if col_diff < 0
        next if space == dest || space == start
        path << space
      end
    else
      puts "**Well this is unexpected**"
    end

    path
  end
end