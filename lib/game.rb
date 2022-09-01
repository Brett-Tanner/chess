# frozen_string_literal: true

require './lib/state.rb'

class Game

  def play
    if File.exist?("./data/*.yaml")
      state = from_yaml()
    else
      state = State.new
      state.create_player("White")
      state.create_player("Black")
    end
    
    winner = loop do
      state.move(state.white_player)
      break state.black_player.name if state.checkmate?
      state.move(state.black_player)
      break state.white_player.name if state.checkmate?
    end
    
    end_game(winner)
  end

  def from_yaml  # TODO:
    # need to search data for all files with *.yaml, return a list and ask which to load
    save_list = Dir["./data/*.yaml"]
    puts "Do you want to load a saved game?"
    save_list.each {|file| puts "#{file.path}"}
    # then initialize a new state with data from that, and return it

    # state
  end

  private

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