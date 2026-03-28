require_relative "domain_event"

module LeeHo
  module Domain
    module Events
      class CrewDidNotHear < DomainEvent
        def initialize(crew_role:)
          super(crew_role: crew_role)
        end

        def crew_role
          payload[:crew_role]
        end
      end
    end
  end
end
