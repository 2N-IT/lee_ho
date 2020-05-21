class BaseSail
  attr_accessor :hauled_or_pulled_counter, :state, :broken
  def initialize
    state = :working
    broken = false
  end

  def broken?
    if broken
      true
    elsif hauled_or_pulled_counter > 9
      broken = true
    else
      false
    end
  end

  def haul
    state = :hauled
    hauled_or_pulled_counter += 1
    true
  end

  def loose
    state = :loosen
    true
  end
end
