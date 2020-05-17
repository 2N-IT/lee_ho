class Crew
  attr_reader :steerman, :foresailman, :mainsailman, :mizzenman

  def initialize
    @steerman =  crew.steerman
    @foresailman =  Foresailman.new
    @mainsailman =  Mainsailman.new
    @mizzenman =  Mizzenman.new
  end


  def ready_about(maneuver)
    all_ready = true
    crew_members.each do |member|
      all_ready = false if !member.ready?
    end
    all_ready
  end

  def crew_members
    [@steerman, @foresailman, @mainsailman, @mizzenman]
  end
end