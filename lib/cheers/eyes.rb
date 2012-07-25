module Cheers
  class Eyes < ImageComponent
    
    IMAGES = %w( eyes/1.png
                 eyes/2.png
                 eyes/3.png
                 eyes/4.png
                 eyes/5.png )
    
    attr_reader :color, :image
    
    def initialize(canvas, color_randomizer, image_randomizer = nil)
      super
      
      @color = ContrastingColorPicker.new(Avatar::COMPONENT_COLORS, canvas.background_color).pick(color_randomizer)
      @image = IMAGES.sample random: self.image_randomizer
    end
    
    def apply
      mask  = Magick::Image.read(image_path(image))[0]
      color = self.color
      
      eyes  = Magick::Image.new(512, 512) do
                self.background_color = color
              end
      
      canvas.add_compose_mask(mask)
      canvas.composite!(eyes, 0, 0, Magick::OverCompositeOp)
      canvas.delete_compose_mask
    end
  end
end
