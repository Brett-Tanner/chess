# frozen_string_literal: true

require './lib/board.rb'
require './lib/human.rb'
require './lib/cpu.rb'

# each piece contains - 
# its own adjaceny list as a class instance variable constant (@@)
# a live copy of the possible moves and a way to prune it
# its symbols to be printed
# its color
# its location on the board (e.g. "\u265A"e5)

# BOARD - 
# TODO: I think board should be the one that requires all the pieces and stores active/taken piece lists
# creates itself as an 8x8 grid of alternating black/white square, with pieces in their starting positions and white at the bottom
# has active/taken pieces list of piece objects
# tracks white and black players
# keeps a list of all moves made
# has get_move method which translates letters to equiv numbers
# rejects moves that hit a friendly space or are invalid

class Game

  def play
    board = Board.new
    white = create_player("White")
    black = create_player("Black")

    winner = loop do
      board.get_move(black.name)
      break @black.name if board.checkmate?
      board.get_move(white.name)
      break @white.name if board.checkmate?
    end
    
    end_game(winner)
  end

  private

  def create_player(color)
    puts "#{color} player, what's your name? Enter CPU to play against the computer"
    name = gets.chomp.capitalize
    return Computer.new if name === "Cpu"
    Human.new(name)
  end

  def end_game(winner)
    puts "Congrats #{winner}, you win!"
    reset_game()
  end

  def reset_game
    puts "Do you want to play again? (y/n)"
    ans = gets.chomp.downcase
    case ans
    when "y"
      return play()
    when "n"
      exit(0)
    else
      puts "**Oops, that's not a y or n**"
      return reset_game()
    end
  end
end