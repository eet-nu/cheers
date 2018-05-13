module Cheers
  class Texture < ImageComponent
    
    IMAGES = %w( texture.png )
    
    attr_reader :color, :image
    
    def initialize(canvas, color_randomizer, element_randomizer = nil)
      super
      
      @image = IMAGES.sample random: element_randomizer
    end
    
    def apply
      texture = MiniMagick::Image.open(image_path(image))
      canvas.composite(texture) do |c|
        c.compose "Over"    # OverCompositeOp
        c.geometry "+0+0"
      end
    end
  end
end
