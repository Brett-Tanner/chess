# frozen_string_literal: true

require './lib/game.rb'

describe Game do
  subject(:game) {described_class.new}

  describe "#play" do
    context "When two names are given" do
      it "creates two human players" do
        
      end
    end

    context "When one name is CPU" do
      it "creates one human, one computer player" do
        
      end
    end

    context "When both names are CPU" do
      it "creates two computer players" do
        
      end
    end

    context "When game is over" do

      it "Asks if you want to play again" do
        
      end

      it "resets the game if you say yes" do
        
      end

      it "exits if you say no" do
        
      end

      context "if black wins" do
        it "displays a personalised victory message" do
          
        end
      end

      context "if white wins" do
        it "displays a personalised victory message" do
          
        end
      end
    end
  end
end