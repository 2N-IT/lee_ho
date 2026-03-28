module LeeHo
  module Domain
    module Services
      class MishearChecker
        def initialize(rng:)
          @rng = rng
        end

        def heard?(mishear_probability)
          !@rng.chance?(mishear_probability)
        end
      end
    end
  end
end
