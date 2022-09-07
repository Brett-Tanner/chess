# frozen_string_literal: true

class Piece

  attr_accessor :symbol, :color
  
  def legal?(start, dest, board)
    return true if @legal_moves[start].include?(dest)
    puts "A #{self.class} can't move like that!"
    false
  end

  def clear_path?(start, dest, board)
    
  end
end