module Skipper
  class LeeHo
    def initialize(boat)
      @boat = boat
      @crew = boat.crew
    end

    def call
      p 'Skipper: Przygotować się do zwrotu przez sztag!'
      @crew.ready_about(:lee_ho)
      p 'Skipper: Ster lewo!'
      @crew.steerman.turn(:left)
      p 'Skipper: Bezana szot wybierz!'
      @crew.mizzenman.pull
      p 'Skipper: Foka szot luz!'
      @crew.foresailman.loose
      p 'Skipper: Grota szot luz!'
      @crew.mainsailman.loose
      p 'Skipper: Bezana szot luz!'
      @crew.mizzenman.loose
      p 'Skipper: Bezana szot wybieraj!'
      @crew.mizzenman.haul
      p 'Skipper: Grota szot wybieraj!'
      @crew.mainsail.haul
      p 'Skipper: Foka szot wybieraj!'
      @crew.foresail.haul
      p 'Skipper: Ster zero!'
      @crew.steerman.keep_her_so
      p 'Skipper: Sternik tak trzymaj!'
      @crew.steerman.steady
      true
    end

  end
end






