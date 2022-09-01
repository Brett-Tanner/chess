# frozen_string_literal: true

describe Game do
  subject(:game) {described_class.new}

  describe "#play" do
    context "When no save file" do
      it "doesn't ask to load" do
        
      end
    end

    context "When 1 or more saves" do
      
      it "asks which you want to load" do
        
      end

      it "creates a State from that file" do
        
      end
    end
  end
end