module Cheers
  class ContrastingColorPicker
    
    MAX_RETRIES = 10
    
    attr_reader :palette, :colors
    
    def initialize(palette, *colors)
      @palette = palette.map { |c| Color.new(c) }
      @colors  = colors.map  { |c| Color.new(c) }
    end
    
    def pick(randomizer = Random.new)
      pick = palette.sample(random: randomizer)
      
      try = 0
      while colors.any? { |c| c.similar?(pick) } && try <= MAX_RETRIES
        try += 1
        pick = palette.sample(random: randomizer)
      end
      
      pick.to_s
    end
  end
end
