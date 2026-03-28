require_relative "crew_member"

module LeeHo
  module Domain
    module Entities
      class ForeSailMan < CrewMember
        MORALE_MIN = 3
        MISHEAR_PROBABILITY = 0.20

        def initialize(mishear_checker:)
          super(name: "Fore Sail Man", mishear_checker: mishear_checker)
        end
      end
    end
  end
end
