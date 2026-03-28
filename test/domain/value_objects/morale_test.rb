require_relative "../../test_helper"

class MoraleTest < Minitest::Test
  Morale = LeeHo::Domain::ValueObjects::Morale

  def test_default_morale_is_5
    assert_equal 5, Morale.new.to_i
  end

  def test_decrease_returns_new_morale
    morale = Morale.new(5)
    decreased = morale.decrease

    assert_equal 4, decreased.to_i
    assert_equal 5, morale.to_i
  end

  def test_decrease_clamps_at_zero
    morale = Morale.new(0)
    assert_equal 0, morale.decrease.to_i
  end

  def test_reset_restores_to_max
    morale = Morale.new(2)
    assert_equal 5, morale.reset.to_i
  end

  def test_sufficient_returns_true_when_above_minimum
    morale = Morale.new(3)
    assert morale.sufficient?(2)
  end

  def test_sufficient_returns_false_when_below_minimum
    morale = Morale.new(1)
    refute morale.sufficient?(2)
  end

  def test_sufficient_returns_true_when_equal_to_minimum
    morale = Morale.new(3)
    assert morale.sufficient?(3)
  end

  def test_equality
    assert_equal Morale.new(3), Morale.new(3)
    refute_equal Morale.new(3), Morale.new(4)
  end

  def test_comparable
    assert Morale.new(5) > Morale.new(3)
    assert Morale.new(1) < Morale.new(4)
  end

  def test_immutability
    morale = Morale.new(3)
    assert morale.frozen?
  end
end
