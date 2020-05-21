module Mizzen
  class MizzenBrokenError < StandardError; end
  class Haul
    attr_accessor :state
    def call(sail)
      if sail.broken?
        raise MizzenBrokenError
      else
        mizzen.haul
      end
    end
  end
end