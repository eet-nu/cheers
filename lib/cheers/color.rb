module Cheers
  
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