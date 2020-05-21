module Steering
  class Steer
    attr_accessor :current_direction

    def turn(direction)
      current_direction = direction
    end
  end
end