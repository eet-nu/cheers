module Cheers
  class Face < ImageComponent
    
    def apply
      [UpperGlow, LowerGlow, Texture, Mouth].each do |klass|
        klass.new(canvas, color_randomizer, image_randomizer.dup).apply
      end
    end
    
  end
end
