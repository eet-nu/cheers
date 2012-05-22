require 'RMagick'
require 'digest/sha1'
require 'tempfile'

module Cheers
  class Avatar
    GEM_ROOT = File.expand_path('../../../', __FILE__)
    
    BACKGROUND_COLORS = ['#cccccc', '#dddddd', '#bbbbbb', '#F1A800', '#FEF0CC', '#fd4238', '#fff0f0', '#14899d', '#c3ecee', '#42991a', '#f0fff0']
    # SMILE_COLORS = ['#333', '#666', '#9e005d', '#ef8200', '#d8a129', '#db4640', '#0e788b', '#239340']
    SMILE_COLORS = ['#333333', '#666666', '#9e005d', '#ef8200', '#db4640', '#0e788b', '#239340']
    IMAGES = {
      
      smiles: [
        { smile:      'components/mouths/1-smile.png',
          smile_glow: 'components/mouths/1-smile-glow.png',
          bg_mask:    'components/mouths/1-bgmask.png',
          texture:    'components/texture.png' },
        { smile:      'components/mouths/2-smile.png',
          smile_glow: 'components/mouths/2-smile-glow.png',
          bg_mask:    'components/mouths/2-bgmask.png',
          texture:    'components/texture.png' },
        { smile:      'components/mouths/3-smile.png',
          smile_glow: 'components/mouths/3-smile-glow.png',
          bg_mask:    'components/mouths/3-bgmask.png',
          texture:    'components/texture.png' }
      ],
      eyes: [
        { eyes: 'components/eyes/1.png' },
        { eyes: 'components/eyes/2.png' },
        { eyes: 'components/eyes/3.png' },
        { eyes: 'components/eyes/4.png' },
        { eyes: 'components/eyes/5.png' }
      ],
      decorations: [
        { id: 1, decoration: 'components/decorations/1.png' },
        { id: 2, decoration: 'components/decorations/2.png' }
      ]
    }
    
    # Creates a new avatar from the seed string
    def initialize(seed)
      @seed = Digest::SHA1.hexdigest(seed).to_i(16)
    end
    
    # Writes avatar image at the provided file path
    def avatar_file(file_path)
      compose_avatar
      
      @avatar.write(file_path)
      
      file_path
    end
    
    private
    
    def compose_avatar #:nodoc:
      random_generator = Random.new(@seed)
      
      # 0. Let's get some random colors
      # We shoudn't change the order we call #rand to keep version changes minimal
      avatar_bg_color  = BACKGROUND_COLORS.sample(random: random_generator)
      smile_components = IMAGES[:smiles].sample(random: random_generator)
      smile_bg_color   = BACKGROUND_COLORS.sample(random: random_generator)
      # smile_color      = SMILE_COLORS.sample(random: random_generator)
      # eyes_color       = SMILE_COLORS.sample(random: random_generator)
      eyes_components  = IMAGES[:eyes].sample(random: random_generator)
      smile_upper_glow_color = SMILE_COLORS.sample(random: random_generator)
      smile_lower_glow_color = SMILE_COLORS.sample(random: random_generator)
      has_decoration   = [true, true, false].sample(random: random_generator)
      decoration_component = IMAGES[:decorations].sample(random: random_generator)
      decoration_color = BACKGROUND_COLORS.sample(random: random_generator)
      
      # Lets test if the color behind eyes is very similar to the eye color.
      # Generate a new eye color if that's the case.
      eyes_contrasting_color = if has_decoration and decoration_component[:id] == 1
        decoration_color
      else
        avatar_bg_color
      end
      
      # Lets not use the same random generator for generating unknown amount of new colors
      rng = Random.new(random_generator.rand(10000)) 
      begin
        eyes_color = SMILE_COLORS.sample(random: rng)
      end while Color.new(eyes_color).similar?(eyes_contrasting_color, 0.2)
      
      # Lets test if the background colors are very similar to the smile color.
      # Change the smile color if that's the case, right?
      rng = Random.new(random_generator.rand(10000))
      begin
        smile_color = SMILE_COLORS.sample(random: rng)
        the_smile_color = Color.new(smile_color)
      end while the_smile_color.similar?(avatar_bg_color, 0.2) or the_smile_color.similar?(smile_bg_color, 0.2)
      
      
      # 1. Lets create upper background
      upper_background = Magick::Image.new(512, 512) { self.background_color = avatar_bg_color }
      
      # This is smile glow mask
      smile_glow_image = Magick::Image.read(component_path(smile_components[:smile_glow]))[0]
      
      # Create smile glow layer and put it on upper background
      smile_upper_glow = Magick::Image.new(512, 512) { self.background_color = smile_upper_glow_color }
      upper_background.add_compose_mask(smile_glow_image)
      upper_background.composite!(smile_upper_glow, 0, 0, Magick::OverCompositeOp)
      upper_background.delete_compose_mask
      
      
      # 2. Lets create lower background
      lower_background = Magick::Image.new(512, 512) { self.background_color = smile_bg_color }
      
      # Create another smile glow layer but put it on lower background
      smile_lower_glow = Magick::Image.new(512, 512) { self.background_color = smile_lower_glow_color }
      lower_background.add_compose_mask(smile_glow_image)
      lower_background.composite!(smile_lower_glow, 0, 0, Magick::OverCompositeOp)
      lower_background.delete_compose_mask
      
      
      # 3. Lets compose both backgrounds together
      
      # This will be the final avatar image.
      # Because we will draw the lower background over the upper background,
      # we can use the upper background as the starting image.
      avatar = upper_background
      
      # Lets mask and put the lower background on top of the image
      avatar.add_compose_mask(Magick::Image.read(component_path(smile_components[:bg_mask]))[0])
      avatar.composite!(lower_background, 0, 0, Magick::OverCompositeOp)
      avatar.delete_compose_mask
      
      # 4. Add decorations
      if has_decoration
        decoration = Magick::Image.new(512, 512) { self.background_color = decoration_color }
        avatar.add_compose_mask(Magick::Image.read(component_path(decoration_component[:decoration]))[0])
        avatar.composite!(decoration, 0, 0, Magick::OverCompositeOp)
        avatar.delete_compose_mask
      end
      
      # 5. Add the texture
      texture = Magick::Image.read(component_path(smile_components[:texture]))[0]
      avatar.composite!(texture, 0, 0, Magick::OverCompositeOp)
      
      smile = Magick::Image.new(512, 512) { self.background_color = smile_color }
      avatar.add_compose_mask(Magick::Image.read(component_path(smile_components[:smile]))[0])
      avatar.composite!(smile, 0, 0, Magick::OverCompositeOp)
      avatar.delete_compose_mask
      
      eyes = Magick::Image.new(512, 512) { self.background_color = eyes_color }
      avatar.add_compose_mask(Magick::Image.read(component_path(eyes_components[:eyes]))[0])
      avatar.composite!(eyes, 0, 0, Magick::OverCompositeOp)
      avatar.delete_compose_mask
      
      @avatar = avatar
    end
    
    def component_path(asset) #:nodoc:
      [GEM_ROOT, asset].join('/')
    end
  end
  
  # Represents a color and allows to compare to others (maybe)
  class Color
    attr_accessor :r, :g, :b
    
    # Create new color from a hex value
    def initialize(color = '#000000')
      hex_string = color[1..6]
      self.r = hex_string[0..1].to_i(16)
      self.g = hex_string[2..3].to_i(16)
      self.b = hex_string[4..5].to_i(16)
    end
    
    # 
    def to_s
      return '#' + r.to_s(16) + g.to_s(16) + b.to_s(16)
    end
    
    def to_hsv
      red, green, blue = [r, g, b].collect {|x| x / 255.0}
      max = [red, green, blue].max
      min = [red, green, blue].min
    
      if min == max
        hue = 0
      elsif max == red
        hue = 60 * ((green - blue) / (max - min))
      elsif max == green
        hue = 60 * ((blue - red) / (max - min)) + 120
      elsif max == blue
        hue = 60 * ((red - green) / (max - min)) + 240
      end
    
      saturation = (max == 0) ? 0 : (max - min) / max
      [hue % 360, saturation, max]
    end
    
    def similar?(other_color, threshold)
      other_color = Color.new(other_color) unless other_color.is_a? Color
      
      color_hsv       = to_hsv
      other_color_hsv = other_color.to_hsv
      
      d_hue        = (color_hsv[0] - other_color_hsv[0]).abs / 360
      d_saturation = (color_hsv[1] - other_color_hsv[1]).abs
      d_value      = (color_hsv[2] - other_color_hsv[2]).abs
      
      if d_hue <= threshold and d_saturation <= threshold and d_value <= threshold
        true
      else
        false
      end
    end
    
  end
end
