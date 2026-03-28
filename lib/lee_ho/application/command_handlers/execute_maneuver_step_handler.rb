require_relative "../../domain/services/tack_sequence"
require_relative "../../domain/events/maneuver_step_completed"

module LeeHo
  module Application
    module CommandHandlers
      class ExecuteManeuverStepHandler
        def initialize(boat:)
          @boat = boat
        end

        def call(command)
          step = Domain::Services::TackSequence.steps[command.step_number - 1]
          return failure("Invalid step number: #{command.step_number}") unless step

          result = @boat.execute_step(step)

          if result.success?
            events = result.events + [
              Domain::Events::ManeuverStepCompleted.new(
                step_number: step.number,
                crew_role: step.crew_role,
                action: step.action
              )
            ]
            Domain::ValueObjects::CommandResult.success(result.message, events: events)
          else
            result
          end
        end

        private

        def failure(message)
          Domain::ValueObjects::CommandResult.failure(message)
        end
      end
    end
  end
end
