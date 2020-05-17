module Steering
  class SteerManMoraleError < StandardError; end
  class SteerMan < CrewMember # how about composition over inheritance? Should we always push it?

    def turn(direction) #czy moze jednak SteermanTurn ? A może Steerman.call('turn') z wzorcem strategii i pomniejszymi klasami ?
      if morale > 1
        puts "Steer Turn #{direction}- Roger!"
        Steering::Turn.call(direction)
      else
        raise SteerManMoraleError
      end
    end

  end
end