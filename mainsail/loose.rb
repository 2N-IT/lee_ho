module Mainsail
  class MainsailBrokenError < StandardError; end
  class Loose
    attr_accessor :state
    def call(sail)
      if sail.broken?
        raise MainsailBrokenError
      else
        sail.loose
      end
    end
  end
end