require_relative "../value_objects/sail_state"
require_relative "../value_objects/wear_level"
require_relative "../value_objects/command_result"
require_relative "../events/kausza_broken"

module LeeHo
  module Domain
    module Entities
      class Sail
        EXTRA_BREAK_CHANCE = 0.0

        attr_reader :name, :state, :wear, :broken

        def initialize(name:, wear_calculator:)
          @name = name.freeze
          @state = ValueObjects::SailState.new(:idle)
          @wear = ValueObjects::WearLevel.new
          @broken = false
          @wear_calculator = wear_calculator
        end

        def broken?
          @broken
        end

        def haul!
          return broken_result if broken?

          @wear = @wear.increment
          check_and_apply_break!
          return broken_result if broken?

          @state = @state.transition_to(:hauled)
          success("#{name} hauled!")
        end

        def release!
          return broken_result if broken?

          @state = @state.transition_to(:released)
          success("#{name} released!")
        end

        def loosen!
          return broken_result if broken?

          @state = @state.transition_to(:loosened)
          success("#{name} loosened!")
        end

        def repair!
          @broken = false
          @wear = @wear.reset
          success("#{name} repaired! Kausza replaced.")
        end

        private

        def check_and_apply_break!
          if @wear_calculator.breaks?(@wear, extra_break_chance: self.class::EXTRA_BREAK_CHANCE)
            @broken = true
          end
        end

        def broken_result
          ValueObjects::CommandResult.failure(
            "#{name} kausza is broken! Needs repair.",
            events: [Events::KauszaBroken.new(sail_name: name)]
          )
        end

        def success(message)
          ValueObjects::CommandResult.success(message)
        end
      end
    end
  end
end
