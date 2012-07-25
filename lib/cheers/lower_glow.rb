module Cheers
  class LowerGlow < ImageComponent
    
    GLOW_IMAGES = %w( mouths/1-smile-glow.png
                      mouths/2-smile-glow.png
                      mouths/3-smile-glow.png )
    
    MASK_IMAGES = %w( mouths/1-bgmask.png
                      mouths/2-bgmask.png
                      mouths/3-bgmask.png )
    
    attr_reader :background_color, :glow_color, :glow_image, :mask_image
    
    def initialize(canvas, color_randomizer, element_randomizer = nil)
      super
      
      @background_color = ContrastingColorPicker.new(Avatar::BACKGROUND_COLORS, canvas.background_color).pick(color_randomizer)
      @glow_color = ContrastingColorPicker.new(Avatar::COMPONENT_COLORS, canvas.background_color, background_color).pick(color_randomizer)
      @glow_image = GLOW_IMAGES.sample random: element_randomizer.dup
      @mask_image = MASK_IMAGES.sample random: element_randomizer.dup
    end
    
    def apply
      glow = Magick::Image.read(image_path(glow_image))[0]
      mask = Magick::Image.read(image_path(mask_image))[0]
      
      # Work around instance_eval wonkiness by declaring local variables:
      glow_color       = self.glow_color
      background_color = self.background_color
      
      # 2. Lets create lower background
      background = Magick::Image.new(512, 512) do
                     self.background_color = background_color
                   end
      
      # Create another smile glow layer but put it on lower background
      glow_background = Magick::Image.new(512, 512) do
               self.background_color = glow_color
              end
      
      background.add_compose_mask(glow)
      background.composite!(glow_background, 0, 0, Magick::OverCompositeOp)
      background.delete_compose_mask
      
      canvas.add_compose_mask(mask)
      canvas.composite!(background, 0, 0, Magick::OverCompositeOp)
      canvas.delete_compose_mask
    end
  end
end
