# frozen_string_literal: true

require './lib/game.rb'

describe Game do
  subject(:game) {described_class.new}

  before do
    allow(game).to receive(:puts)
    allow(game).to receive(:loop).and_yield
    allow_any_instance_of(Board).to receive(:puts)
  end

  describe "#play" do

    context "When two names are given" do

      before do
        allow(game).to receive(:gets).and_return("Brett", "Viktoria")
        allow(game).to receive(:end_game)
      end

      it "creates two human players" do
        brett = Human.new("Brett")
        vik = Human.new("Viktoria")
        expect(Human).to receive(:new).twice.and_return(brett, vik)
        game.play
      end
    end

    context "When one name is CPU" do

      before do
        allow(game).to receive(:gets).and_return("Brett", "CPU")
        allow(game).to receive(:end_game)
      end

      it "creates one human, one computer player" do
        brett = Human.new("Brett")
        cpu = Computer.new
        expect(Human).to receive(:new).once.and_return(brett)
        expect(Computer).to receive(:new).once.and_return(cpu)
        game.play
      end
    end

    context "When both names are CPU" do

      before do
        allow(game).to receive(:gets).and_return("cpu", "CPU")
        allow(game).to receive(:end_game)
      end

      it "creates two computer players" do
        cpu = Computer.new
        expect(Computer).to receive(:new).twice.and_return(cpu, cpu)
        game.play
      end
    end
  end
end