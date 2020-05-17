module Mizzen
  class Pull
    attr_accessor :state
    def call
      state = :working
    end
  end
end