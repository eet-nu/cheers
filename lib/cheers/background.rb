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

      colored_image(color)
    end
  end
end
