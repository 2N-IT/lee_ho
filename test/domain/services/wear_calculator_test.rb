require_relative "../../test_helper"

class WearCalculatorTest < Minitest::Test
  include TestSupport
  WearLevel = LeeHo::Domain::ValueObjects::WearLevel

  def test_not_broken_below_threshold
    rng = build_deterministic_rng
    calc = LeeHo::Domain::Services::WearCalculator.new(rng: rng)
    refute calc.breaks?(WearLevel.new(5))
  end

  def test_broken_at_threshold
    rng = build_deterministic_rng
    calc = LeeHo::Domain::Services::WearCalculator.new(rng: rng)
    assert calc.breaks?(WearLevel.new(10))
  end

  def test_extra_chance_triggers_with_failing_rng
    rng = build_always_failing_rng
    calc = LeeHo::Domain::Services::WearCalculator.new(rng: rng)
    assert calc.breaks?(WearLevel.new(3), extra_break_chance: 0.20)
  end

  def test_extra_chance_does_not_trigger_with_safe_rng
    rng = build_deterministic_rng
    calc = LeeHo::Domain::Services::WearCalculator.new(rng: rng)
    refute calc.breaks?(WearLevel.new(3), extra_break_chance: 0.20)
  end
end
