class CrewMember
  attr_accessor :morale
  def initalize
    morale = 5
  end

  def ready?(maneuver)
    if morale > 0
      puts "Ready to #{maneuver}!"
      true
    else
      false
    end
  end
end