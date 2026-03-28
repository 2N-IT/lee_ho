require_relative "../../test_helper"

class SailStateTest < Minitest::Test
  SailState = LeeHo::Domain::ValueObjects::SailState

  def test_default_state_is_idle
    assert_equal :idle, SailState.new.to_sym
  end

  def test_valid_transitions_from_idle
    state = SailState.new(:idle)
    assert_equal :hauled, state.transition_to(:hauled).to_sym
    assert_equal :released, state.transition_to(:released).to_sym
    assert_equal :loosened, state.transition_to(:loosened).to_sym
  end

  def test_invalid_transition_raises
    state = SailState.new(:hauled)
    assert_raises(SailState::InvalidTransitionError) do
      state.transition_to(:idle)
    end
  end

  def test_valid_transitions_from_hauled
    state = SailState.new(:hauled)
    assert_equal :released, state.transition_to(:released).to_sym
    assert_equal :loosened, state.transition_to(:loosened).to_sym
  end

  def test_invalid_state_raises
    assert_raises(ArgumentError) { SailState.new(:flying) }
  end

  def test_equality
    assert_equal SailState.new(:hauled), SailState.new(:hauled)
    refute_equal SailState.new(:hauled), SailState.new(:released)
  end

  def test_immutability
    state = SailState.new(:idle)
    assert state.frozen?
  end
end
