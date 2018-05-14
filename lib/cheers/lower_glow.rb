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

      canvas_background = extract_background_color(canvas)
      
      @background_color = ContrastingColorPicker.new(Avatar::BACKGROUND_COLORS, canvas_background).pick(color_randomizer)
      @glow_color = ContrastingColorPicker.new(Avatar::COMPONENT_COLORS, canvas_background, background_color).pick(color_randomizer)
      @glow_image = GLOW_IMAGES.sample random: element_randomizer.dup
      @mask_image = MASK_IMAGES.sample random: element_randomizer.dup
    end
    
    def apply
      glow_color       = self.glow_color
      background_color = self.background_color

      background = composite_with_mask(colored_image(background_color), colored_image(glow_color), glow_image)

      composite_with_mask(canvas, background, mask_image)
    end
  end
end
