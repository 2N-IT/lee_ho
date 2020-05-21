module Foresail
  class ForesailBrokenError < StandardError; end
  class Haul
    attr_accessor :state
    def call(foresail)
      if foresail.broken? < 10
        raise ForesailBrokenError
      else
        foresail.haul
      end
    end
  end
end