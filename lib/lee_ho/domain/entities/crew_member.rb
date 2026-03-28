require_relative "../value_objects/morale"
require_relative "../value_objects/command_result"
require_relative "../events/crew_did_not_hear"
require_relative "../events/morale_too_low"

module LeeHo
  module Domain
    module Entities
      class CrewMember
        MORALE_MIN = 0
        MISHEAR_PROBABILITY = 0.0

        attr_reader :name, :morale

        def initialize(name:, mishear_checker:)
          @name = name.freeze
          @morale = ValueObjects::Morale.new
          @mishear_checker = mishear_checker
        end

        def execute_order(&action)
          return did_not_hear_result unless heard?
          return morale_too_low_result unless morale_sufficient?

          result = action.call
          @morale = @morale.decrease
          result
        end

        def motivate!
          @morale = @morale.reset
          ValueObjects::CommandResult.success("#{name} motivated! Morale restored to #{@morale}.")
        end

        def morale_sufficient?
          @morale.sufficient?(self.class::MORALE_MIN)
        end

        private

        def heard?
          @mishear_checker.heard?(self.class::MISHEAR_PROBABILITY)
        end

        def did_not_hear_result
          ValueObjects::CommandResult.failure(
            "#{name} didn't hear the command!",
            events: [Events::CrewDidNotHear.new(crew_role: name)]
          )
        end

        def morale_too_low_result
          ValueObjects::CommandResult.failure(
            "#{name}'s morale is too low (#{@morale}/#{self.class::MORALE_MIN} needed)!",
            events: [Events::MoraleTooLow.new(
              crew_role: name,
              current_morale: @morale.to_i,
              required_morale: self.class::MORALE_MIN
            )]
          )
        end
      end
    end
  end
end
