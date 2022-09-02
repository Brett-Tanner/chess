# frozen_string_literal: true

require './lib/state.rb'
require 'yaml'

class Game

  def play
    state = from_yaml()

    if state == nil
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

  def from_yaml
    save_list = Dir["./data/*.yaml"]
    return nil if save_list.empty?

    puts "Enter to skip, or type the game you want to load"
    save_list.each {|file| puts file.delete_prefix("./data/").delete_suffix(".yaml")}
    save_path = "./data/#{gets.chomp}.yaml"
    return nil unless save_list.include?(save_path)

    create_state(save_path)
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

  def create_state(save_path) #FIXME: deleting the save causes issues with subsequent tests
    saved_state = YAML.load_file(save_path)
    
    p File.exist?(save_path)
    p saved_state

    board = saved_state[:board]
    list = saved_state[:move_list]
    white = saved_state[:white_player]
    black = saved_state[:black_player]

    # File.delete(save_path)
    State.new(board, list, white, black)
  end
end