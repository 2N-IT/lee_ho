module Skipper
  class LeeHo
    def call
      Crew.ready_about('lee_ho')
      SteermanTurn.call('left')
      MizenSailPull.call
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






