# frozen_string_literal: true

require './lib/human.rb'
require './lib/cpu.rb'
require './lib/bishop.rb'
require './lib/rook.rb'
require './lib/king.rb'
require './lib/knight.rb'
require './lib/pawn.rb'
require './lib/queen.rb'

# has updated active pieces list of piece objects
# keeps a list of all moves made
# has move method
# rejects moves that hit a friendly space or are invalid

class State

  attr_accessor :board, :active_pieces, :white_player, :black_player

  def initialize(board = [], list = [], active = [], white = nil, black = nil)
    @active_pieces = active
    @move_list = list
    @board = board.empty? ? create_board() : board
    @white_player = white
    @black_player = black
  end

  def create_board
    black_back_row = ["H", Rook.new("black"), Knight.new("black"), Bishop.new("black"), King.new("black"), Queen.new("black"), Bishop.new("black"), Knight.new("black"), Rook.new("black")]
    black_back_row.each {|value| @active_pieces << value unless value == "H"}

    black_front_row = Array.new(8, Pawn.new("black")).unshift("G")
    black_front_row.each {|value| @active_pieces << value unless value == "G"}
    white_front_row = Array.new(8, Pawn.new("white")).unshift("B")
    white_front_row.each {|value| @active_pieces << value unless value == "B"}


    white_back_row = ["A", Rook.new("white"), Knight.new("white"), Bishop.new("white"), King.new("white"), Queen.new("white"), Bishop.new("white"), Knight.new("white"), Rook.new("white")]
    white_back_row.each {|value| @active_pieces << value unless value == "A"}


    board = Hash.new
    board[:col_nums] = Array.new(8) {|i| i + 1}.unshift(" ")
    board[8] = black_back_row
    board[7] = black_front_row
    board[6] = Array.new(8, " ").unshift("F")
    board[5] = Array.new(8, " ").unshift("E")
    board[4] = Array.new(8, " ").unshift("D")
    board[3] = Array.new(8, " ").unshift("C")
    board[2] = white_front_row
    board[1] = white_back_row

    board
  end

  def print_board
    @board.each do |key, row| 
      row.each_with_index do |space, index|
        next print " #{space} " if space.class == Integer 

        if space.class == String
          if space.match?(/[A-H]/) || key == :col_nums
            next print " #{space} "
          elsif white_space?(key, index)
            next print "#{white(space)}"
          else
            next print "#{black(space)}"
          end
        end

        # catches pieces as they have many different classes
        if white_space?(key, index)
          print "#{white(space.symbol)}"
        else
          print "#{black(space.symbol)}"
        end
      end

      # separates rows
      puts ""

    end
  end

  def create_player(color)
    puts "#{color} player, what's your name? Enter CPU to play against the computer"
    name = gets.chomp.capitalize
    if color == "White"
      return @white_player = Computer.new("White") if name === "Cpu"
      @white_player = Human.new(name, "White")
    else
      return @black_player = Computer.new("Black") if name === "Cpu"
      @black_player = Human.new(name, "Black")
    end
  end

  def move(player)
    move = move_input(player)
    start = move[0]
    dest = move[1]

    player_piece = @board[start[0]][start[1]]
    target = @board[dest[0]][dest[1]]

    return move(player) if invalid_move?(player_piece, target) || player_piece.invalid_move?(start, dest)

    # make_move(start, dest)
    # @move_list << [start, dest]
    # @active_pieces.delete(target) if target.class != String
  end

  def checkmate?
    
  end

  def save
    
  end

  private

  def white_space?(key, index)
    (key.even? && index.even?) || (key.odd? && index.odd?)
  end

  def colorize(text, color_code)
    "#{color_code} #{text} \e[0m"
  end
  
  def white(text)
    colorize(text, "\u001b[47;1m")
  end
  
  def black(text)
    colorize(text, "\u001b[46;1m")
  end

  def move_input(player)
    puts "#{player.name}, what's your move?"
    input = gets.chomp.split("to").map {|coord| coord.strip.upcase}

    # convert rows from letters to row index
    start = [to_row(input[0][0]), input[0][1].to_i]
    dest = [to_row(input[1][0]), input[1][1].to_i]

    return [start, dest] if inbounds?(start, dest)
    move_input(player)
  end

  def inbounds?(start, dest)
    return true if start.all? {|i| i >= 0 && i <= 7} && dest.all? {|i| i >= 1 && i <= 8}
    puts "**Your coordinates are out of bounds**"
    false
  end

  def invalid_move?(player_piece, target)
    return true if friendly_fire?(player_piece, target)
    # check piece's move matrix to see if it's possible
    # check for check if piece is king
  end

  def friendly_fire?(player_piece, target)
    return false if target.class == String
    return false if player_piece.color != target.color
    puts "**You can't take your own piece!**"
    true
  end

  def check? # TODO:
    
  end

  def make_move(start, dest) # TODO:
    
  end

  def to_row(letter)
    rel_array = %w[nil A B C D E F G H]
    return rel_array.index(letter) if rel_array.include?(letter)
    20
  end
end

test = State.new
test.print_board