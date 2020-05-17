module Skipper
  class LeeHo
    def initialize
      @crew = Crew.new
    end

    def call
      Crew.ready_about('lee_ho')
      @crew.steerman.turn('left')
      @crew.mizzenman.pull
      @crew.foresailman.loose
      MainsailRelease.call
      MizzenRelease.call
      MizzenHaul.call
      MainSailHaul.call
      ForesailHaul.call
      SteerKeepHerSo.call
      SteerSteady.call
    end

  end
end






