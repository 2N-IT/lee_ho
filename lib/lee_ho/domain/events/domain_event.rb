module LeeHo
  module Domain
    module Events
      class DomainEvent
        attr_reader :occurred_at, :payload

        def initialize(**payload)
          @occurred_at = Time.now.freeze
          @payload = payload.freeze
          freeze
        end

        def type
          self.class.name.split("::").last
        end

        def to_s
          "#{type}(#{payload.map { |k, v| "#{k}: #{v}" }.join(', ')})"
        end
      end
    end
  end
end
