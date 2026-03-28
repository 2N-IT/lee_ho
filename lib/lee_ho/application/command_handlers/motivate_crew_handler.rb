module LeeHo
  module Application
    module CommandHandlers
      class MotivateCrewHandler
        def initialize(boat:)
          @boat = boat
        end

        def call(command)
          crew_member = @boat.crew_member_for(command.crew_role)
          return failure("Unknown crew role: #{command.crew_role}") unless crew_member

          crew_member.motivate!
        end

        private

        def failure(message)
          Domain::ValueObjects::CommandResult.failure(message)
        end
      end
    end
  end
end
