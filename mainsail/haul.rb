module Mainsail
  class MainsailBrokenError < StandardError; end
  class Haul
    attr_accessor :state
    def call(sail)
      if sail.broken?
        raise MainsailBrokenError
      else
        sail.haul
      end
    end
  end
end