require_relative "../../test_helper"

class SailTest < Minitest::Test
  include TestSupport

  def setup
    @rng = build_deterministic_rng
    @wear_calc = LeeHo::Domain::Services::WearCalculator.new(rng: @rng)
    @sail = LeeHo::Domain::Entities::Sail.new(name: "Test Sail", wear_calculator: @wear_calc)
  end

  def test_initial_state_is_idle
    assert_equal :idle, @sail.state.to_sym
  end

  def test_initial_wear_is_zero
    assert_equal 0, @sail.wear.to_i
  end

  def test_not_broken_initially
    refute @sail.broken?
  end

  def test_haul_transitions_to_hauled
    result = @sail.haul!
    assert result.success?
    assert_equal :hauled, @sail.state.to_sym
  end

  def test_haul_increments_wear
    @sail.haul!
    assert_equal 1, @sail.wear.to_i
  end

  def test_release_transitions_to_released
    @sail.haul!
    result = @sail.release!
    assert result.success?
    assert_equal :released, @sail.state.to_sym
  end

  def test_release_does_not_increment_wear
    @sail.haul!
    @sail.release!
    assert_equal 1, @sail.wear.to_i
  end

  def test_broken_sail_cannot_haul
    10.times { @sail.haul!; @sail.release! unless @sail.broken? }
    result = @sail.haul!
    assert result.failure?
    assert_match(/broken/, result.message)
  end

  def test_repair_resets_broken_and_wear
    10.times { @sail.haul!; @sail.release! unless @sail.broken? }
    @sail.repair!
    refute @sail.broken?
    assert_equal 0, @sail.wear.to_i
  end

  def test_broken_sail_emits_kausza_broken_event
    10.times { @sail.haul!; @sail.release! unless @sail.broken? }
    result = @sail.haul!
    kausza_event = result.events.find { |e| e.is_a?(LeeHo::Domain::Events::KauszaBroken) }
    assert kausza_event
    assert_equal "Test Sail", kausza_event.sail_name
  end
end
