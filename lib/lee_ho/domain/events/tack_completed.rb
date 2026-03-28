require_relative "domain_event"

module LeeHo
  module Domain
    module Events
      class TackCompleted < DomainEvent
        def initialize(tack_number:)
          super(tack_number: tack_number)
        end

        def tack_number
          payload[:tack_number]
        end
      end
    end
  end
end
