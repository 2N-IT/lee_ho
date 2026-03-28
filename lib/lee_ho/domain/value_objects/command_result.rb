module LeeHo
  module Domain
    module ValueObjects
      class CommandResult
        attr_reader :message, :events

        def initialize(success:, message:, events: [])
          @success = success.freeze
          @message = message.freeze
          @events = events.freeze
          freeze
        end

        def success?
          @success
        end

        def failure?
          !@success
        end

        def self.success(message, events: [])
          new(success: true, message: message, events: events)
        end

        def self.failure(message, events: [])
          new(success: false, message: message, events: events)
        end

        def ==(other)
          other.is_a?(self.class) &&
            success? == other.success? &&
            message == other.message
        end
        alias eql? ==

        def hash
          [self.class, @success, message].hash
        end

        def to_s
          prefix = success? ? "OK" : "FAIL"
          "[#{prefix}] #{message}"
        end
      end
    end
  end
end
