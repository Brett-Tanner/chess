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

  def find_path(start, dest) # nested ifs deal with pos/neg change
    row_diff = dest[0] - start[0]
    col_diff = dest[1] - start[1]
    path = []

    if row_diff != 0 && col_diff == 0 # vertical movement
      if row_diff > 0
        first_move = 1
        (first_move...row_diff).each {|i| path << [start[0] + i, start[1]]}
      end
      if row_diff < 0
        first_move = -1
        row_diff += 1 # to prevent the target space being checked
        (row_diff..first_move).each {|i| path << [start[0] + i, start[1]]}
      end
    elsif row_diff == 0 && col_diff != 0 # horizontal movement
      if col_diff > 0
        first_move = 1
        (first_move...col_diff).each {|i| path << [start[0], start[1] + i]}
      end
      if col_diff < 0
        first_move = -1
        col_diff += 1 # to prevent the target space being checked
        (col_diff..first_move).each {|i| path << [start[0], start[1] + i]}
      end
    elsif row_diff == col_diff # diagonal movement
      if row_diff > 0
        first_move = 1
        (first_move...row_diff).each {|i| path << [start[0] + i, start[1] + i]}
      end
      if row_diff < 0
        first_move = -1
        row_diff += 1 # to prevent the target space being checked
        (row_diff..first_move).each {|i| path << [start[0] + i, start[1] + i]}
      end
    else
     puts "**Well this is unexpected**"
    end

    path
  end
end