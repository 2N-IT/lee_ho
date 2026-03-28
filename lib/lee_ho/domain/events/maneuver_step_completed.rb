require_relative "domain_event"

module LeeHo
  module Domain
    module Events
      class ManeuverStepCompleted < DomainEvent
        def initialize(step_number:, crew_role:, action:)
          super(step_number: step_number, crew_role: crew_role, action: action)
        end

        def step_number
          payload[:step_number]
        end

        def crew_role
          payload[:crew_role]
        end

        def action
          payload[:action]
        end
      end
    end
  end
end
