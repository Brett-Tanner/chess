# frozen_string_literal: true

require './lib/state.rb'
require './lib/human.rb'
require './lib/cpu.rb'

class Game

  def play
    state = State.new
    white = create_player("White")
    black = create_player("Black")

    winner = loop do
      state.get_move(black.name)
      break @black.name if state.checkmate?
      state.get_move(white.name)
      break @white.name if state.checkmate?
    end
    
    end_game(winner)
  end

  private

  def load  # TODO: add this once you implement #save on State class
    
  end

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