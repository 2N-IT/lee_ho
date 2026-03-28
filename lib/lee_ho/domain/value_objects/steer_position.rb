module LeeHo
  module Domain
    module ValueObjects
      class SteerPosition
        POSITIONS = %i[left right neutral].freeze

        attr_reader :position

        def initialize(position = :neutral)
          raise ArgumentError, "Invalid position: #{position}" unless POSITIONS.include?(position)

          @position = position.freeze
          freeze
        end

        def left?
          position == :left
        end

        def right?
          position == :right
        end

        def neutral?
          position == :neutral
        end

        def ==(other)
          other.is_a?(self.class) && position == other.position
        end
        alias eql? ==

        def hash
          [self.class, position].hash
        end

        def to_sym
          position
        end

        def to_s
          position.to_s
        end
      end
    end
  end
end
