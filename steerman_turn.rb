module Steerman
  class Turn
    def call(direction)
      if steer.working?
        SteerTurn.call(direction)
      else
        false # maybe throw an error instead?
      end
    end
  end
end