module LeeHo
  module Infrastructure
    module Random
      class Rng
        def initialize(seed: nil)
          @random = seed ? ::Random.new(seed) : ::Random.new
        end

        def chance?(probability)
          @random.rand < probability
        end

        def roll
          @random.rand
        end
      end
    end
  end
end
