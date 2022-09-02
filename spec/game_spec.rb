# frozen_string_literal: true

require './lib/game.rb'
require 'yaml'

describe Game do
  subject(:game) {described_class.new}

  describe "#from_yaml" do

    let(:path1) {'./data/test_v_test.yaml'}      
    let(:path2) {'./data/test_v_Brett.yaml'}
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
      

      before do
        allow(game).to receive(:gets).and_return('test_v_Brett')

        # FIXME: something in this block causes the problem, but still no idea what
        # test1 = File.new(path1, 'w')
        # test1.puts "#{save_state}"
        # test2 = File.new(path2, 'w')
        # test2.puts "#{save_state}"
      end

      it "returns a State object" do
        return_value = game.from_yaml
        expect(return_value).to be_an_instance_of State
      end
      
      it "displays a list of saves to choose from" do
        expect(game).to receive(:puts).exactly(3).times
        game.from_yaml
      end

      # after do
      #   File.delete(path1) if File.exist?(path1)
      #   File.delete(path2) if File.exist?(path2)
      # end
    end

    context "When no save file" do
      it "returns nil" do
        return_value = game.from_yaml
        expect(return_value).to be nil
      end
    end
  end
end