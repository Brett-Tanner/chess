# frozen_string_literal: true

require './lib/human.rb'
require './lib/cpu.rb'
require './lib/bishop.rb'
require './lib/rook.rb'
require './lib/king.rb'
require './lib/knight.rb'
require './lib/pawn.rb'
require './lib/queen.rb'

require 'yaml'

class State

  attr_accessor :board, :white_player, :black_player, :move_list

  def initialize(board = [], list = [], white = nil, black = nil)
    @move_list = list
    @board = board.empty? ? create_board() : board
    @white_player = white
    @black_player = black
  end

  def create_board
    black_back_row = ["H", Rook.new("Black"), Knight.new("Black"), Bishop.new("Black"), Queen.new("Black"), King.new("Black"), Bishop.new("Black"), Knight.new("Black"), Rook.new("Black")]

    black_front_row = Array.new(8, Pawn.new("Black")).unshift("G")
    white_front_row = Array.new(8, Pawn.new("White")).unshift("B")


    white_back_row = ["A", Rook.new("White"), Knight.new("White"), Bishop.new("White"), Queen.new("White"), King.new("White"), Bishop.new("White"), Knight.new("White"), Rook.new("White")]


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
    print_board()
    move = move_input(player)
    start = move[0]
    dest = move[1]
    player_piece = @board[start[0]][start[1]]
    if player_piece.class == String
      puts "You just tried to move an empty space?"
      return move(player)
    end
    target = @board[dest[0]][dest[1]]

    return move(player) unless valid_move?(player_piece, target, start, dest, player)
    return move(player) if check?(start, dest, player)

    make_move(start, dest)
    @move_list << [start, dest]
    promote(dest, player_piece) if promoted?(dest, player_piece)
  end

  def checkmate?(player)
    king_coord = find_king(@board, player)
    king_row = king_coord[0]
    king_col = king_coord[1]
    king = @board[king_row][king_col]
    possible_moves = king.legal_moves[king_coord]
    
    return false if possible_moves.any? do |target_coord| 
      target_col = target_coord[0]
      target_row = target_coord[1]
      target = @board[target_row][target_col]
      valid_move?(king, target, king_coord, target_coord, player)
    end
    true
  end

  def save
    filename = "./data/#{@white_player.name}_vs_#{@black_player.name}.yaml"
    save_state = YAML.dump ({
      :board => @board,
      :move_list => @move_list,
      :white_player => @white_player,
      :black_player => @black_player,
    })
    save_file = File.open(filename, "w")
    save_file.puts "#{save_state}"
    puts "Game saved successfully!" if File.exist?(filename)
    exit(0)
  end

  private

  def valid_move?(player_piece, target, start, dest, player)
    return false if friendly_fire?(player_piece, target)
    return false unless player_piece.legal?(start, dest, @board) && player_piece.clear_path?(start, dest, @board)
    true
  end

  def move_input(player)
    puts "#{player.name}, what's your move?"
    input = gets.chomp.split("to").map {|coord| coord.strip.upcase}
    return save() if input == ["SAVE"]

    # convert rows from letters to row index
    start = [to_row(input[0][0]), input[0][1].to_i]
    dest = [to_row(input[1][0]), input[1][1].to_i]

    return [start, dest] if inbounds?(start, dest)
    move_input(player)
  end

  def inbounds?(start, dest)
    return true if start.all? {|i| i >= 1 && i <= 8} && dest.all? {|i| i >= 1 && i <= 8}
    puts "**Your coordinates are out of bounds**"
    false
  end

  def friendly_fire?(player_piece, target)
    return false if target.class == String || player_piece.color != target.color
    puts "**You can't take your own piece!**"
    true
  end

  def check?(start, dest, player)
    # create duplicate board
    board_copy = Hash.new
    @board.each {|k, v| board_copy[k] = v.dup}

    # make the desired move on that baord
    moved_piece = board_copy[start[0]][start[1]]
    target = board_copy[dest[0]][dest[1]]
    board_copy[dest[0]][dest[1]] = moved_piece
    board_copy[start[0]][start[1]] = " "

    king = find_king(board_copy, player)
    king_row = king[0]
    king_col = king[1]

    # check if the king can be taken by any piece on that duplicate board
    board_copy.each do |row_index, row|
      row.each_index do |col_index|
        piece = board_copy[row_index][col_index]
        next if piece.class == String || piece.class == Integer || piece.color == player.color
        
        takes_king = piece.legal?([row_index, col_index], [king_row, king_col], board_copy, "n")
        if takes_king
          puts "**You can't move your king into check**"
          return true
        end
      end
    end
    false
  end

  def find_king(board, player)
    king = []
    board.each do |row_index, row|
      next if row_index == :col_nums
      row.each_index do |col_index|
        space = board[row_index][col_index]
        next if space.class == String
        king = [row_index, col_index] if space.class == King && space.color == player.color
      end
    end
    king
  end

  def promoted?(piece_coords, piece)
    color = piece.color
    row = piece_coords[0]
    return true if (color == "White" && row == 8) || (color == "Black" && row == 1)
    false
  end

  def promote(piece_coords, piece)
    puts "What should your pawn be promoted to?"
    new_piece = gets.chomp.capitalize
    row = piece_coords[0]
    col = piece_coords[1]
    color = piece.color

    case new_piece
    when "Rook"
      @board[row][col] = Rook.new("#{color}")
    when "Knight"
      @board[row][col] = Knight.new("#{color}")
    when "Bishop"
      @board[row][col] = Bishop.new("#{color}")
    when "Queen"
      @board[row][col] = Queen.new("#{color}")
    else
      puts "That's not a valid piece!"
      return promote(piece_coords, piece)
    end
  end

  def make_move(start, dest)
    piece = @board[start[0]][start[1]]
    target = @board[dest[0]][dest[1]]

    @board[dest[0]][dest[1]] = piece
    @board[start[0]][start[1]] = " "
  end

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

  def to_row(letter)
    rel_array = %w[nil A B C D E F G H]
    return rel_array.index(letter) if rel_array.include?(letter)
    20
  end
end