require_relative "../value_objects/steer_position"
require_relative "../value_objects/command_result"

module LeeHo
  module Domain
    module Entities
      class Steer
        attr_reader :position

        def initialize
          @position = ValueObjects::SteerPosition.new(:neutral)
        end

        def turn(direction)
          @position = ValueObjects::SteerPosition.new(direction)
          ValueObjects::CommandResult.success("Helm #{direction}!")
        end

        def center!
          @position = ValueObjects::SteerPosition.new(:neutral)
          ValueObjects::CommandResult.success("Helm centered!")
        end

        def steady!
          ValueObjects::CommandResult.success("Steady as she goes!")
        end
      end
    end
  end
end
