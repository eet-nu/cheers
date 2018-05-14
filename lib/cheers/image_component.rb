module Cheers
  class ImageComponent < Component
    
    attr_reader :canvas, :color_randomizer, :image_randomizer
    
    def initialize(canvas, color_randomizer, image_randomizer = nil)
      @canvas           = canvas
      @color_randomizer = color_randomizer
      @image_randomizer = image_randomizer || color_randomizer
    end

  end
end
