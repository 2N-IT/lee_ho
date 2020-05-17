class Boat
  attr_reader :steer, :foresail, :mainsail, :mizzensail
  def initialize
    @steer = Steer.new
    @foresail = Foresail.new
    @mainsail = Mainsail.new
    @mizzensail = Mizzensail.new
  end
end