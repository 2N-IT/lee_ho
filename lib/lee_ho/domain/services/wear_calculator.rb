module LeeHo
  module Domain
    module Services
      class WearCalculator
        def initialize(rng:)
          @rng = rng
        end

        def breaks?(wear_level, extra_break_chance: 0.0)
          wear_level.broken? || @rng.chance?(extra_break_chance)
        end
      end
    end
  end
end
