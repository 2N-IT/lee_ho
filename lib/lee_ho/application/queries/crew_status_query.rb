module LeeHo
  module Application
    module Queries
      class CrewStatusQuery
        def initialize(boat:)
          @boat = boat
        end

        def call
          @boat.all_crew.map do |member|
            {
              name: member.name,
              morale: member.morale.to_i
            }
          end
        end
      end
    end
  end
end
