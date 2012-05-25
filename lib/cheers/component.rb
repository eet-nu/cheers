module Cheers
  class Component
    
    attr_reader :canvas, :randomizer
    
    def initialize(canvas, randomizer)
      @canvas     = canvas
      @randomizer = randomizer
    end
    
  end
end
