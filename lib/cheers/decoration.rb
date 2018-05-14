module Cheers
  class Decoration < ImageComponent
    
    IMAGES = %w( decorations/1.png
                 decorations/2.png )
    
    attr_reader :color, :image
    
    def initialize(canvas, color_randomizer, image_randomizer = nil)
      super
      
      @color = ContrastingColorPicker.new(Avatar::BACKGROUND_COLORS, extract_background_color(canvas)).pick(color_randomizer)
      @image = IMAGES.sample random: self.image_randomizer
    end
    
    def apply?
      [true, true, false].sample(random: image_randomizer)
    end
    
    def apply
      return canvas unless apply?
      super
    end
  end
end
