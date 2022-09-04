# frozen_string_literal: true

require './lib/knight.rb'

describe Knight do
  subject(:knight) {described_class.new}

  describe "#legal?" do
    context "When the move is legal" do
      it "returns true" do
        
      end
    end

    context "When the move isn't legal" do
      it "returns false" do
        
      end
    end
  end
end