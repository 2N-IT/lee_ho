module Mizzen
  class MizzenBrokenError < StandardError; end
  class Loose
    attr_accessor :state
    def call(sail)
      if sail.broken?
        raise MizzenBrokenError
      else
        mizzen.loose
      end
    end
  end
end