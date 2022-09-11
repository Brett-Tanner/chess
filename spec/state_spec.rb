# frozen_string_literal: true

require './lib/state.rb'
require './lib/king.rb'
require './lib/queen.rb'
require './lib/pawn.rb'

describe State do
  subject(:state) {described_class.new}
  subject(:king) {King.new("White")}
  subject(:queen) {Queen.new("Black")}
  subject(:pawn) {Pawn.new("White")}

  let(:w_player) {double('player', name: "Brett", color: "White")}
  let(:b_player) {double('b_player', name: "Viktoria", color: "Black")}

  before do
    allow(state).to receive(:puts)
    allow(state).to receive(:print)
  end

  describe "#create_board" do
    subject(:board) {described_class.new.board}

    it {is_expected.to be_an_instance_of Hash}

    it "is 9x9" do
      num_rows = board.length
      row_length = board[1].length 
      expect(num_rows).to eql(9)
      expect(row_length).to eql(9)
    end
  end

  describe "#print_board" do

      it "prints 9 lines" do
        expect(state).to receive(:puts).exactly(9).times
        state.print_board
      end

      it "prints 9 columns" do
        expect(state).to receive(:print).exactly(81).times
        state.print_board
      end
  end

  describe "#move" do

    context "When input is out of bounds" do

      before do
        allow(state).to receive(:gets).and_return("a9 to b9", "b2 to d2")  
      end

      it "displays an error message" do
        error = "**Your coordinates are out of bounds**"
        expect(state).to receive(:puts).with(error).once
        state.move(w_player)
      end

      it "asks for new inputs" do
        message = "Brett, what's your move?"
        expect(state).to receive(:puts).with(message).twice
        state.move(w_player)
      end
    end

    context "When the space is occupied by friendly piece" do
      let(:board) {
        board = Hash.new
        (1..8).each {|i| board[i] = [" ", " ", " ", " ", " ", " ", " ", " "]}
        board[4][4] = king
        board[5][5] = pawn
        board[8][8] = queen
        board
      }

      before do
        state.board = board
        allow(state).to receive(:gets).and_return("d4 to e5", "d4 to e4")
      end
      
      it "displays an error" do
        error = "**You can't take your own piece!**"
        expect(state).to receive(:puts).with(error).once
        state.move(w_player)
      end

      it "asks for new inputs" do
        message = "Brett, what's your move?"
        expect(state).to receive(:puts).with(message).twice
        state.move(w_player)
      end

      after :each do
        state.board = state.create_board
      end
    end

    context "When the player's King is in check" do
      let(:board) {
        board = Hash.new
        (1..8).each {|i| board[i] = [" ", " ", " ", " ", " ", " ", " ", " "]}
        board[4][4] = king
        board[5][5] = pawn
        board[8][8] = queen
        board
      }

      before do
        state.board = board
        allow(state).to receive(:gets).and_return("e5 to f5", "d4 to e4")
      end

      it "displays an error" do
        error = "**You can't move your king into check**"
        expect(state).to receive(:puts).with(error).once
        state.move(w_player)
      end

      it "asks for new inputs" do
        message = "Brett, what's your move?"
        expect(state).to receive(:puts).with(message).twice
        state.move(w_player)
      end

      after :each do
        state.board = state.create_board
      end
    end

    context "When the piece can't move like that" do
      let(:board) {
        board = Hash.new
        (1..8).each {|i| board[i] = [" ", " ", " ", " ", " ", " ", " ", " "]}
        board[4][4] = king
        board[5][5] = pawn
        board[8][8] = queen
        board
      }

      before do
        state.board = board
        allow(state).to receive(:gets).and_return("d4 to g5", "d4 to e4")
        allow(king).to receive(:puts)
      end

      it "displays an error" do
        error = "A King can't move like that!"
        expect(king).to receive(:puts).with(error).once
        state.move(w_player)
      end

      it "asks for new inputs" do
        message = "Brett, what's your move?"
        expect(state).to receive(:puts).with(message).twice
        state.move(w_player)
      end

      after :each do
        state.board = state.create_board
      end
    end

    context "When there are other pieces blocking the path" do
      let(:board) {
        board = Hash.new
        (1..8).each {|i| board[i] = [" ", " ", " ", " ", " ", " ", " ", " "]}
        board[4][4] = king
        board[5][5] = pawn
        board[8][8] = queen
        board
      }

      before do
        state.board = board
        allow(state).to receive(:gets).and_return("h8 to d4", "h8 to e5")
        allow(queen).to receive(:puts)
      end

      it "displays an error" do
        error = "There's a piece blocking your Queen!"
        expect(queen).to receive(:puts).with(error).once
        state.move(b_player)
      end

      it "asks for new inputs" do
        message = "Viktoria, what's your move?"
        expect(state).to receive(:puts).with(message).twice
        state.move(b_player)
      end

      after :each do
        state.board = state.create_board
      end
    end

    context "When move is valid, nothing taken" do

      before do
        allow(state).to receive(:gets).and_return("b7 to d7")
      end

      it "changes the starting space" do
        original_contents = state.board[2][7]
        expect {state.move(w_player)}.to change {state.board[2][7]}.from(original_contents).to(" ")
      end

      it "changes the destination space" do
        original_contents = state.board[4][7]
        new_contents = state.board[2][7]
        expect {state.move(w_player)}.to change {state.board[4][7]}.from(original_contents).to(new_contents)
      end
      
      it "pushes start and destination to move_list" do
        state.move(w_player)
        last_move = state.instance_variable_get(:@move_list).last
        move = [[2, 7], [4, 7]]
        expect(last_move).to eq(move)
      end

      it "doesn't display any errors" do
        boundary_error = "**Your coordinates are out of bounds**"
        friendly_error = "**You can't take your own piece!**"
        check_error = "**You can't move your king into check**"
        expect(state).not_to receive(:puts).with(boundary_error)
        expect(state).not_to receive(:puts).with(friendly_error)
        expect(state).not_to receive(:puts).with(check_error)
      end
    end

    context "When a Pawn makes it to the other side" do

      before do
        state.board[7][7] = Pawn.new("White")
        allow(state).to receive(:gets).and_return("g7 to h8", "Queen")
      end

      it "is offered a promotion" do
        message = "What should your pawn be promoted to?"
        expect(state).to receive(:puts).with(message).once
        state.move(w_player)
      end

      it "changes to the chosen piece" do
        state.move(w_player)
        promoted_piece = state.board[8][8].class
        expect(promoted_piece).to eq(Queen)
      end

      it "creates a piece of the player's color" do
        state.move(w_player)
        color = state.board[8][8].color
        expect(color).to eql("White")
      end

      after :each do
        state.board = state.create_board
      end
    end
  end

  describe "#checkmate?" do
    context "When it's checkmate" do
      let(:board) {
        board = Hash.new
        (1..8).each {|i| board[i] = [" ", " ", " ", " ", " ", " ", " ", " "]}
        board[4][4] = king
        board[5][5] = queen
        board[4][5] = queen
        board[3][5] = queen
        board[3][4] = queen
        board[3][3] = queen
        board[4][3] = queen
        board[5][3] = queen
        board[5][4] = queen
        board
      }

      before do
        state.board = board
      end

      it "returns true" do
        checkmate = state.checkmate?(w_player)
        expect(checkmate).to be true
      end

      after do
        state.board = state.create_board
      end
    end

    context "When it's not checkmate" do
      let(:board) {
        board = Hash.new
        (1..8).each {|i| board[i] = [" ", " ", " ", " ", " ", " ", " ", " "]}
        board[4][4] = king
        board
      }

      before do
        state.board = board
      end

      it "returns false" do
        checkmate = state.checkmate?(w_player)
        expect(checkmate).to be false
      end

      after do
        state.board = state.create_board
      end
    end
  end

  describe "#save" do
    let(:p1) {double("p1", name: "Brett")}
    let(:p2) {double("p2", name: "Viktoria")}
    let(:filename) {"./data/Brett_vs_Viktoria.yaml"}

    subject(:state_save) {described_class.new(["I'm a board!"], ["I'm a move list!"], p1, p2)}

    it "creates a .yaml file using player names" do
      state_save.save
      exists = File.exist?(filename)
      expect(exists).to be true
      File.delete(filename)
    end
  end
end