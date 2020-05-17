class Steer
  attr_accessible :current_direction

  def turn(direction, crew_member)
    current_direction = direction
  end

  def working?
    crew_member.morale < 2
  end

end