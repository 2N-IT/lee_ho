module LeeHo
  module Application
    module Queries
      class ManeuverProgressQuery
        def initialize(tack_number:, current_step:)
          @tack_number = tack_number
          @current_step = current_step
        end

        def call
          {
            tack_number: @tack_number,
            total_tacks: 10,
            current_step: @current_step,
            total_steps: Domain::Services::TackSequence.step_count
          }
        end
      end
    end
  end
end
