module Steering
  class SteerBrokenError < StandardError; end
  class Turn
    def call(direction)
      if steer.working?
        SteerTurn.call(direction)
      else
        raise SteerBrokenError
      end
    end
  end
end