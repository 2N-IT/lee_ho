require_relative "domain_event"

module LeeHo
  module Domain
    module Events
      class MoraleTooLow < DomainEvent
        def initialize(crew_role:, current_morale:, required_morale:)
          super(crew_role: crew_role, current_morale: current_morale, required_morale: required_morale)
        end

        def crew_role
          payload[:crew_role]
        end

        def current_morale
          payload[:current_morale]
        end

        def required_morale
          payload[:required_morale]
        end
      end
    end
  end
end
