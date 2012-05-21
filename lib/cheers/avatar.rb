require 'RMagick'
require 'digest/sha1'
require 'tempfile'

module Cheers
  class Avatar
    GEM_ROOT = File.expand_path('../../../', __FILE__)
    
    BACKGROUND_COLORS = ['#cccccc', '#dddddd', '#bbbbbb', '#F1A800', '#FEF0CC', '#fd4238', '#fff0f0', '#14899d', '#c3ecee', '#42991a', '#f0fff0']
    SMILE_COLORS = ['#333', '#666', '#9e005d', '#ef8200', '#d8a129', '#db4640', '#0e788b', '#239340']
    IMAGES = {
      smiles: [
        { smile:      'components/mouths/1-smile.png',
          smile_glow: 'components/mouths/1-smile-glow.png',
          bg_mask:    'components/mouths/1-bgmask.png',
          texture:    'components/mouths/1-texture.png' },
        { smile:      'components/mouths/2-smile.png',
          smile_glow: 'components/mouths/2-smile-glow.png',
          bg_mask:    'components/mouths/2-bgmask.png',
          texture:    'components/mouths/1-texture.png' },
        { smile:      'components/mouths/3-smile.png',
          smile_glow: 'components/mouths/3-smile-glow.png',
          bg_mask:    'components/mouths/3-bgmask.png',
          texture:    'components/mouths/1-texture.png' }
      ],
      eyes: [
        { eyes: 'components/eyes/1.png' },
        { eyes: 'components/eyes/2.png' },
        { eyes: 'components/eyes/3.png' },
        { eyes: 'components/eyes/4.png' },
        { eyes: 'components/eyes/5.png' }
      ]
    }
    
    def initialize(seed)
      @seed = Digest::SHA1.hexdigest(seed).to_i(16)
    end
    
    def avatar_file(file_path)
      compose_avatar
      
      @avatar.write(file_path)
      
      file_path
    end
    
    private
    
    def compose_avatar
      random_generator = Random.new(@seed)
      
      # 0. Let's get some random colors
      # We shoudn't change the order we call #rand to keep version changes minimal
      avatar_bg_color  = BACKGROUND_COLORS.sample(random: random_generator)
      smile_components = IMAGES[:smiles].sample(random: random_generator)
      smile_bg_color   = BACKGROUND_COLORS.sample(random: random_generator)
      smile_color      = SMILE_COLORS.sample(random: random_generator)
      eyes_color       = SMILE_COLORS.sample(random: random_generator)
      eyes_components  = IMAGES[:eyes].sample(random: random_generator)
      smile_upper_glow_color = SMILE_COLORS.sample(random: random_generator)
      smile_lower_glow_color = SMILE_COLORS.sample(random: random_generator)
      
      
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
      
      
      # 3. Lets compose both background together
      
      # This will be the final avatar image.
      # Because we will draw the lower background over the upper background,
      # we can use the upper background as the starting image.
      avatar = upper_background
      
      # Lets mask and put the lower background on top of the image
      avatar.add_compose_mask(Magick::Image.read(component_path(smile_components[:bg_mask]))[0].negate(true))
      avatar.composite!(lower_background, 0, 0, Magick::OverCompositeOp)
      avatar.delete_compose_mask
      
      # Add the texture
      if smile_components[:texture]
        texture = Magick::Image.read(component_path(smile_components[:texture]))[0]
        avatar.composite!(texture, 0, 0, Magick::OverCompositeOp)
      end
      
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
    
    def component_path(asset)
      [GEM_ROOT, asset].join('/')
    end
  end
end
