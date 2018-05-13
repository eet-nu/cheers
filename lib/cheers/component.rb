module Cheers
  class Component
    
    attr_reader :canvas, :randomizer
    
    def initialize(canvas, randomizer)
      @canvas     = canvas
      @randomizer = randomizer
    end

    def image_path(component)
      [Cheers.root, 'components', component].join '/'
    end

    def base_image
      MiniMagick::Image.open(image_path('blank.png'))
    end

    def colored_image(color)
      image =  MiniMagick::Image.open(image_path('blank.png'))

      image.combine_options do |c|
        c.resize '512x512'
        c.fuzz "100%"
        c.fill color
        c.floodfill "+0+0", 'white'
      end
    end

    def composite_with_mask(base, second, mask_image)
      mask = MiniMagick::Image.open(image_path(mask_image))
      mask.combine_options do |m|
        m.alpha 'copy'
      end

      base.composite(second, 'png', mask)
    end

    # assumes top left pixel is background since none of the parts overlap there
    def extract_background_color(image)
      rgb = image.get_pixels[0][0]
      Color.rgb_to_hex(rgb)
    end

    def apply
      color = self.color
      composite_with_mask(canvas, colored_image(color), image)
    end
  end
end
