# frozen_string_literal: true

class Piece

  attr_accessor :symbol, :color
  
  def legal?(start, dest, board)
    return true if @legal_moves[start].include?(dest)
    puts "A #{self.class} can't move like that!"
    false
  end

  def clear_path?(start, dest, board)
    # find difference between start and dest
    
    # use them to make the path the piece would take
    path = find_path(start, dest)
    # check path for obstructions (by checking the class of the squares)
      # remember to exclude the destination itself from the path, it can be occupied
    p path

    # if at least one path is all empty squares, return true

    # if both paths have at least one piece in the way, displays an error and returns false
    puts "You can't move there, your path is blocked!"
    false
  end

  private

  def find_path(start, dest)
    row_diff = start[0] - dest[0]
    col_diff = start[1] - dest[1]
    path = []
   if row_diff != 0 && col_diff == 0 # vertical movement
    (1...row_diff).each {|i| path << [start[0] + i, start[1]]}
   elsif row_diff == 0 && col_diff != 0 # horizontal movement
    (1...col_diff).each {|i| path << [start[0], start[1] + i]}
   elsif row_diff == col_diff # diagonal movement
    (1...row_diff).each {|i| path << [start[0] + i, start[1] + i]}
   else
    puts "**Well this is unexpected**"
   end
   path
  end
end