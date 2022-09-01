# frozen_string_literal: true

require './lib/state.rb'

class Game

  def play
    state = State.new
    state.create_player("White")
    state.create_player("Black")

    winner = loop do
      state.move(state.white_player)
      break state.black_player.name if state.checkmate?
      state.move(state.black_player)
      break state.white_player.name if state.checkmate?
    end
    
    end_game(winner)
  end

  private

  def load  # TODO: add this once you implement #save on State class
    # need to search data for all files with *.yaml, return a list and ask which to load

    # then initialize a new state with data from that
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