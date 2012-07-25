module Cheers
  class Decoration < ImageComponent
    
    IMAGES = %w( decorations/1.png
                 decorations/2.png )
    
    attr_reader :color, :image
    
    def initialize(canvas, color_randomizer, image_randomizer = nil)
      super
      
      @color = ContrastingColorPicker.new(Avatar::BACKGROUND_COLORS, canvas.background_color).pick(color_randomizer)
      @image = IMAGES.sample random: self.image_randomizer
    end
    
    def apply?
      [true, true, false].sample(random: image_randomizer)
    end
    
    def apply
      return unless apply?
      
      mask  = Magick::Image.read(image_path(image))[0]
      color = self.color
      
      decoration = Magick::Image.new(512, 512) do
                     self.background_color = color
                   end
      
      canvas.add_compose_mask(mask)
      canvas.composite!(decoration, 0, 0, Magick::OverCompositeOp)
      canvas.delete_compose_mask
    end
  end
end
