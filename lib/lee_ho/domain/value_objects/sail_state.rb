module LeeHo
  module Domain
    module ValueObjects
      class SailState
        STATES = %i[idle hauled released loosened].freeze

        VALID_TRANSITIONS = {
          idle:     %i[hauled released loosened],
          hauled:   %i[released loosened],
          released: %i[hauled loosened],
          loosened: %i[hauled released]
        }.freeze

        attr_reader :state

        def initialize(state = :idle)
          raise ArgumentError, "Invalid state: #{state}" unless STATES.include?(state)

          @state = state.freeze
          freeze
        end

        def transition_to(new_state)
          unless can_transition_to?(new_state)
            raise InvalidTransitionError, "Cannot transition from #{state} to #{new_state}"
          end

          self.class.new(new_state)
        end

        def can_transition_to?(new_state)
          VALID_TRANSITIONS.fetch(state, []).include?(new_state)
        end

        def ==(other)
          other.is_a?(self.class) && state == other.state
        end
        alias eql? ==

        def hash
          [self.class, state].hash
        end

        def to_sym
          state
        end

        def to_s
          state.to_s
        end

        class InvalidTransitionError < StandardError; end
      end
    end
  end
end
