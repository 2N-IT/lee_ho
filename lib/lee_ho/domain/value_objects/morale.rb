module LeeHo
  module Domain
    module ValueObjects
      class Morale
        include Comparable

        MAX = 5
        MIN = 0

        attr_reader :value

        def initialize(value = MAX)
          @value = value.clamp(MIN, MAX).freeze
          freeze
        end

        def decrease
          self.class.new(value - 1)
        end

        def reset
          self.class.new(MAX)
        end

        def sufficient?(minimum)
          value >= minimum
        end

        def <=>(other)
          value <=> other.value
        end

        def ==(other)
          other.is_a?(self.class) && value == other.value
        end
        alias eql? ==

        def hash
          [self.class, value].hash
        end

        def to_i
          value
        end

        def to_s
          value.to_s
        end
      end
    end
  end
end
