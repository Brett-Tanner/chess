# frozen_string_literal: true

require './lib/state.rb'

describe State do
  subject(:state) {described_class.new}

  # context "When called with default arguments" do
    
  #   it "initializes with default arguments" do
      
  #   end
  # end

  # context "When called with save file info" do
    
  #   it "initializes with that info" do
      
  #   end
  # end

  describe "#create_board" do
    subject(:board) {described_class.new.board}

    it {is_expected.to be_an_instance_of Hash}

    it "the array is 8x8" do
      num_rows = board.length
      row_length = board[:a].length 
      expect(num_rows).to eql(8)
      expect(row_length).to eql(8)
    end
  end


  describe "#print_board" do
    subject(:print_board) {described_class.new.print_board}
  end


  describe "#save" do
    
  end
end