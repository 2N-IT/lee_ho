class CrewMember
  attr_accessor :morale, :name, :assigned_to
  def initalize(name, assigned_to)
    morale = 5
    name = name
    assigned_to = assigned_to
  end

  def ready?(maneuver)
    #raise DidntHearError if didnt_hear?
    puts "Ready to #{maneuver}!"
    true
  end
end