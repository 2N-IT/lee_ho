class Crew
  attr_reader :steerman, :mainsailman, :mizzenman, :foresailman

  #kolejnosc alfabetyczna czy w kolejnosci ukladu na jachcie ? jak daleko posunac sie z odzwierciedlaniem domeny w kodzie?
  def initialize
    @steerman    =  Steering::SteerMan.new
    @mizzenman   =  Mizzensail::MizzensailMan.new
    @mainsailman =  Mainsailman.new
    @foresailman =  Foresailman.new
  end


  def ready_about(maneuver)
    all_ready = true
    crew_members.each do |member|
      all_ready = false if !member.ready?(maneuver)
    end
    all_ready
  end

  def crew_members
    [@steerman, @foresailman, @mainsailman, @mizzenman]
  end
end