require_relative "../../test_helper"

class WearLevelTest < Minitest::Test
  WearLevel = LeeHo::Domain::ValueObjects::WearLevel

  def test_default_count_is_zero
    assert_equal 0, WearLevel.new.to_i
  end

  def test_increment_returns_new_wear_level
    wear = WearLevel.new(5)
    incremented = wear.increment

    assert_equal 6, incremented.to_i
    assert_equal 5, wear.to_i
  end

  def test_broken_at_threshold
    wear = WearLevel.new(10)
    assert wear.broken?
  end

  def test_not_broken_below_threshold
    wear = WearLevel.new(9)
    refute wear.broken?
  end

  def test_reset_returns_zero
    wear = WearLevel.new(8)
    assert_equal 0, wear.reset.to_i
  end

  def test_equality
    assert_equal WearLevel.new(3), WearLevel.new(3)
    refute_equal WearLevel.new(3), WearLevel.new(4)
  end

  def test_immutability
    wear = WearLevel.new(3)
    assert wear.frozen?
  end

  def test_to_s
    assert_equal "5/10", WearLevel.new(5).to_s
  end
end
