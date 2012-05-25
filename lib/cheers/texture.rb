module Cheers
  class Texture < ImageComponent
    
    IMAGES = %w( texture.png )
    
    attr_reader :color, :image
    
    def initialize(canvas, color_randomizer, element_randomizer = nil)
      super
      
      @image = IMAGES.sample random: element_randomizer
    end
    
    def apply
      texture = Magick::Image.read(image_path(image))[0]
      canvas.composite!(texture, 0, 0, Magick::OverCompositeOp)
    end
  end
end
