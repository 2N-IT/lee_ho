module Steering
  class SteerBrokenError < StandardError; end
  class Turn
    def call(direction)
      Steering::Steer.turn(direction)
    end
  end
end