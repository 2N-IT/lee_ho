module Steering
  class MizzenManMoraleError < StandardError; end
  class MizzenMan < CrewMember # how about composition over inheritance? Should we always push it?

    def pull
      if morale > 1
        puts 'Mizzenl Pull - Roger!'
        Mizzen::Pull.call
      else
        raise MizzenManMoraleError
      end
    end

  end
end