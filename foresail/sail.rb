module Foresail
  class Sail < BaseSail
    MORALE_NEEDED = 3

    def broken?
      if rand(5) == 0
        broken = true
        super
      end
    end
  end
end