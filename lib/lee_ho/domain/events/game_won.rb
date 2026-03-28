require_relative "domain_event"

module LeeHo
  module Domain
    module Events
      class GameWon < DomainEvent
        def initialize(total_tacks:)
          super(total_tacks: total_tacks)
        end

        def total_tacks
          payload[:total_tacks]
        end
      end
    end
  end
end
