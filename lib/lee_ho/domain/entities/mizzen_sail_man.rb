require_relative "crew_member"

module LeeHo
  module Domain
    module Entities
      class MizzenSailMan < CrewMember
        MORALE_MIN = 0
        MISHEAR_PROBABILITY = 0.40

        def initialize(mishear_checker:)
          super(name: "Mizzen Sail Man", mishear_checker: mishear_checker)
        end
      end
    end
  end
end
