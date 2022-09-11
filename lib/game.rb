# frozen_string_literal: true

require './lib/state.rb'
require 'yaml'

class Game

  @current_player = nil

  def play
    state = from_yaml()

    if @current_player == "Black"
      winner = loop do
        state.move(state.black_player)
        break state.black_player.name if state.checkmate?(state.white_player)state.move(state.white_player)
        break state.white_player.name if state.checkmate?(state.black_player)
      end
    end

    if @current_player == "White"
      winner = loop do
        state.move(state.white_player)
        break state.white_player.name if state.checkmate?(state.black_player)
        state.move(state.black_player)
        break state.black_player.name if state.checkmate?(state.white_player)
      end
    end

    if state == nil
      state = State.new
      state.create_player("White")
      state.create_player("Black")
    
      winner = loop do
        state.move(state.white_player)
        break state.white_player.name if state.checkmate?(state.black_player)
        state.move(state.black_player)
        break state.black_player.name if state.checkmate?(state.white_player)
      end
    end
    
    end_game(winner)
  end

  def from_yaml
    save_list = Dir["./data/*.yaml"]
    return nil if save_list.empty?

    puts "Enter to skip, or type the game you want to load"
    save_list.each {|file| puts file.delete_prefix("./data/").delete_suffix(".yaml")}
    save_path = "./data/#{gets.chomp}.yaml"
    return nil unless File.exist?(save_path)

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

  def create_state(save_path)
    saved_state = YAML.load_file(save_path)

    board = saved_state[:board]
    list = saved_state[:move_list]
    white = saved_state[:white_player]
    black = saved_state[:black_player]
    @current_player = saved_state[:current_player]

    File.delete(save_path) unless save_path.include?("test")
    State.new(board, list, white, black)
  end
end

game = Game.new
game.play