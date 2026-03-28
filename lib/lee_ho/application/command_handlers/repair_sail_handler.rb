module LeeHo
  module Application
    module CommandHandlers
      class RepairSailHandler
        def initialize(boat:)
          @boat = boat
        end

        def call(command)
          sail = @boat.sail_for_action(command.sail_action)
          return failure("No sail found for action: #{command.sail_action}") unless sail

          sail.repair!
        end

        private

        def failure(message)
          Domain::ValueObjects::CommandResult.failure(message)
        end
      end
    end
  end
end
