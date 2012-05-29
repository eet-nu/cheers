module Cheers
  class Background < Component
    
    attr_reader :color
    
    def initialize(canvas, randomizer)
      super
      
      @color = Avatar::BACKGROUND_COLORS.sample(random: randomizer)
    end
    
    def apply
      # Work around instance_eval wonkiness by declaring local variables:
      color = self.color
        
      background = Magick::Image.new(512, 512) do
        self.background_color = color
      end
      
      canvas.composite!(background, 0, 0, Magick::OverCompositeOp)
    end
  end
end
