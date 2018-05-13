module Cheers
  class Mouth < ImageComponent
    
    IMAGES = %w( mouths/1-smile.png
                 mouths/2-smile.png
                 mouths/3-smile.png )
    
    attr_reader :color, :image
    
    def initialize(canvas, color_randomizer, element_randomizer = nil)
      super
      
      @color = ContrastingColorPicker.new(Avatar::COMPONENT_COLORS, extract_background_color(canvas)).pick(color_randomizer)
      @image = IMAGES.sample random: element_randomizer
    end

  end
end
