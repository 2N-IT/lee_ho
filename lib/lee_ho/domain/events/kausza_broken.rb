require_relative "domain_event"

module LeeHo
  module Domain
    module Events
      class KauszaBroken < DomainEvent
        def initialize(sail_name:)
          super(sail_name: sail_name)
        end

        def sail_name
          payload[:sail_name]
        end
      end
    end
  end
end
