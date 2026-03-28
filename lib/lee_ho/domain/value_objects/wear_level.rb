module LeeHo
  module Domain
    module ValueObjects
      class WearLevel
        include Comparable

        BREAK_THRESHOLD = 10

        attr_reader :count

        def initialize(count = 0)
          @count = [count, 0].max.freeze
          freeze
        end

        def increment
          self.class.new(count + 1)
        end

        def reset
          self.class.new(0)
        end

        def broken?
          count >= BREAK_THRESHOLD
        end

        def <=>(other)
          count <=> other.count
        end

        def ==(other)
          other.is_a?(self.class) && count == other.count
        end
        alias eql? ==

        def hash
          [self.class, count].hash
        end

        def to_i
          count
        end

        def to_s
          "#{count}/#{BREAK_THRESHOLD}"
        end
      end
    end
  end
end
