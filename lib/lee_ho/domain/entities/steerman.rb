require_relative "crew_member"

module LeeHo
  module Domain
    module Entities
      class Steerman < CrewMember
        MORALE_MIN = 2
        MISHEAR_PROBABILITY = 0.20

        def initialize(mishear_checker:)
          super(name: "Steerman", mishear_checker: mishear_checker)
        end
      end
    end
  end
end
