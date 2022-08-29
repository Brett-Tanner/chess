# frozen_string_literal: true

class Computer

  attr_accessor :name, :color
  
  def initialize(color)
    @name = "CPU"
    @color = color
  end
end