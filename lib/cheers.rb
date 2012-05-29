$LOAD_PATH << File.expand_path('../', __FILE__)

module Cheers
  autoload :VERSION, 'cheers/version'
  
  autoload :Avatar,                 'cheers/avatar'
  autoload :Background,             'cheers/background'
  autoload :Color,                  'cheers/color'
  autoload :Component,              'cheers/component'
  autoload :ContrastingColorPicker, 'cheers/contrasting_color_picker'
  autoload :Decoration,             'cheers/decoration'
  autoload :Eyes,                   'cheers/eyes'
  autoload :Face,                   'cheers/face'
  autoload :ImageComponent,         'cheers/image_component'
  autoload :LowerGlow,              'cheers/lower_glow'
  autoload :Mouth,                  'cheers/mouth'
  autoload :Texture,                'cheers/texture'
  autoload :UpperGlow,              'cheers/upper_glow'
  
  def self.root
    File.expand_path('../../', __FILE__)
  end
end
