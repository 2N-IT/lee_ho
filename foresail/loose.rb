module Foresail
  class ForesailBrokenError < StandardError; end
  class Loose
    attr_accessor :state
    def call(foresail)
      if foresail.broken? < 10
        raise ForesailBrokenError
      else
        foresail.loose
      end
    end
  end
end