# frozen_string_literal: true

require './lib/game.rb'

describe Game do
  subject(:game) {described_class.new}

  before do
    allow_any_instance_of(State).to receive(:move)
    allow_any_instance_of(State).to receive(:checkmate?).and_return(true)
    allow(game).to receive(:loop).and_yield
    allow(game).to receive(:end_game)
  end

  describe "#from_yaml" do

    context "When no save file" do
      it "doesn't ask to load" do
        message = "Do you want to load a saved game?"
        expect(game).not_to receive(:puts).with(message)
        game.from_yaml
      end
    end

    context "When 1 or more saves" do

      # you should create the testfile/s here, duh
      
      it "asks which you want to load" do
        message = "Do you want to load a saved game?"
        expect(game).to receive(:puts).with(message)
        game.from_yaml
      end

      it "creates a State from that file" do
        board = "I'm a board!"
        move_list = "I'm a move list!"
        white_player = # no idea how to read it
        black_player = # no idea how to read it
        expect(State).to receive(:new).with(board, move_list, white_player, black_player)
        game.from_yaml
      end

      it "returns a State object" do
        return_value = game.from_yaml
        expect(return_value).to be_an_instance_of State
      end
    end

    after do
      # and delete the test file/s here
    end
  end
end