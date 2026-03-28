module LeeHo
  module Application
    module Queries
      class BoatStatusQuery
        def initialize(boat:)
          @boat = boat
        end

        def call
          {
            steer: @boat.steer.position.to_s,
            sails: @boat.all_sails.map { |sail| sail_status(sail) }
          }
        end

        private

        def sail_status(sail)
          {
            name: sail.name,
            state: sail.state.to_s,
            wear: sail.wear.to_s,
            broken: sail.broken?
          }
        end
      end
    end
  end
end
