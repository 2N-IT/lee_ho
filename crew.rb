class Crew
  attr_reader :steerman, :mainsailman, :mizzenman, :foresailman

  #kolejnosc alfabetyczna czy w kolejnosci ukladu na jachcie ? jak daleko posunac sie z odzwierciedlaniem domeny w kodzie?
  def initialize(boat)
    @steerman    =  Steering::Man.new('Marek', boat.steer)
    @mizzenman   =  Mizzen::MizzenMan.new('Zosia', boat.mizzen)
    @mainsailman =  Mainsail::MainsailMan.new('Bogdan', boat.mainsail)
    @foresailman =  Foresail::ForesailMan.new('Grażyna', boat.foresail)
  end

  def ready_about(maneuver)
    all_ready = true
    crew_members.each do |member|
      all_ready = false if !member.ready?(maneuver)
    end
    all_ready
  end

  private
  def crew_members
    [steerman, foresailman, mainsailman, mizzenman]
  end
end