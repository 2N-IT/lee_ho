module Skipper
  class LeeHo
    def initialize
      @crew = Crew.new
    end

    def call
      Crew.ready_about('lee_ho')
      Steerman::Turn.call('left')
      MizenSail::Pull.call(@crew.mizzenman)
      LeftJibSheetRellease.call
      MainsailRelease.call
      MizzenSailRelease.call
      MizzenSailHaul.call
      MainSailHaul.call
      ForesailHaul.call
      SteerKeepHerSo.call
      SteerSteady.call
    end

  end
end






