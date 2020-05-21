module Steering
  class ManMoraleError < StandardError; end
  class Man < CrewMember # how about composition over inheritance? Should we always push it?

    def turn(direction)
      raise SteerManMoraleError if morale < 1
      puts "Steer Turn #{direction}- Roger!"
      morale -= 1
      Steering::Turn.call(direction, assigned_to)
    end

  end
end