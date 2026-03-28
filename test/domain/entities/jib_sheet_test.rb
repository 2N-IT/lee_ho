require_relative "../../test_helper"

class JibSheetTest < Minitest::Test
  include TestSupport

  def test_extra_break_chance_is_twenty_percent
    assert_equal 0.20, LeeHo::Domain::Entities::JibSheet::EXTRA_BREAK_CHANCE
  end

  def test_jib_breaks_randomly_with_failing_rng
    rng = build_always_failing_rng
    wear_calc = LeeHo::Domain::Services::WearCalculator.new(rng: rng)
    jib = LeeHo::Domain::Entities::JibSheet.new(name: "Left Jib", wear_calculator: wear_calc)

    jib.haul!
    assert jib.broken?
  end

  def test_jib_survives_with_safe_rng
    rng = build_deterministic_rng
    wear_calc = LeeHo::Domain::Services::WearCalculator.new(rng: rng)
    jib = LeeHo::Domain::Entities::JibSheet.new(name: "Left Jib", wear_calculator: wear_calc)

    jib.haul!
    refute jib.broken?
  end
end
