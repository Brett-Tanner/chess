# frozen_string_literal: true

require './lib/game.rb'
require 'yaml'

describe Game do
  subject(:game) {described_class.new}

  describe "#from_yaml" do

    let(:path1) {'./data/dummy1.yaml'}      
    let(:path2) {'./data/dummy2.yaml'}
    let(:save_state) {YAML.dump ({
      :board => "I'm a board",
      :move_list => "I'm a list",
      :white_player => "I'm a player",
      :black_player => "I'm another player"
    })}
    
    before do
      allow(game).to receive(:puts)
    end

    context "When 1 or more saves" do
      
      before :each do
        allow(game).to receive(:gets).and_return('/test/test_v_Brett')

        test1 = File.new(path1, 'w') unless File.exist?(path1)
        test1.puts save_state unless test1 == nil
        test2 = File.new(path2, 'w') unless File.exist?(path2)
        test2.puts save_state unless test2 == nil
      end

      it "returns a State object" do
        return_value = game.from_yaml
        expect(return_value).to be_an_instance_of State
      end

      it "with the dummy values" do
        return_value = game.from_yaml
        board = return_value.board
        move_list = return_value.move_list
        white_player = return_value.white_player
        black_player = return_value.black_player
        expect(board).to eq("I'm a board")
        expect(move_list).to eq("I'm a list")
        expect(white_player).to eq("I'm a player")
        expect(black_player).to eq("I'm another player")
      end
      
      it "displays a list of saves to choose from" do
        expect(game).to receive(:puts).exactly(3).times
        game.from_yaml
      end

      after :all do
        File.delete('./data/dummy1.yaml') if File.exist?('./data/dummy1.yaml')
        File.delete('./data/dummy2.yaml') if File.exist?('./data/dummy2.yaml')
      end
    end

    context "When no save file" do

      it "returns nil" do
        return_value = game.from_yaml
        expect(return_value).to be nil
      end
    end
  end
end