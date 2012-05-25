module Cheers
  class ImageComponent
    
    attr_reader :canvas, :color_randomizer, :image_randomizer
    
    def initialize(canvas, color_randomizer, image_randomizer = nil)
      @canvas           = canvas
      @color_randomizer = color_randomizer
      @image_randomizer = image_randomizer || color_randomizer
    end
    
    private
    
    def image_path(component)
      [Cheers.root, 'components', component].join '/'
    end
  end
end
