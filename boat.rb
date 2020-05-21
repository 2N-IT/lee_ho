class Boat
  attr_reader :steer, :foresail, :mainsail, :mizzensail
  def initialize
    @steer = ::Steering::Steer.new
    @foresail = Foresail::Sail.new
    @mainsail = Mainsail::Sail.new
    @mizzen = Mizzen::Sail.new
    @crew = Crew.new(self)
  end
end