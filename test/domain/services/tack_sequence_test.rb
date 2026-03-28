require_relative "../../test_helper"

class TackSequenceTest < Minitest::Test
  TackSequence = LeeHo::Domain::Services::TackSequence

  def test_has_eleven_steps
    assert_equal 11, TackSequence.step_count
  end

  def test_steps_are_frozen
    assert TackSequence.steps.frozen?
  end

  def test_first_step_is_ready_about
    step = TackSequence.steps.first
    assert_equal 1, step.number
    assert_equal :all, step.crew_role
    assert_equal :ready_about, step.action
  end

  def test_last_step_is_steady
    step = TackSequence.steps.last
    assert_equal 11, step.number
    assert_equal :steerman, step.crew_role
    assert_equal :steady, step.action
  end

  def test_step_numbers_are_sequential
    expected = (1..11).to_a
    actual = TackSequence.steps.map(&:number)
    assert_equal expected, actual
  end

  def test_correct_crew_assignments
    assignments = TackSequence.steps.map { |s| [s.number, s.crew_role] }
    expected = [
      [1, :all], [2, :steerman], [3, :mizzen_sail_man],
      [4, :fore_sail_man], [5, :main_sail_man], [6, :mizzen_sail_man],
      [7, :mizzen_sail_man], [8, :main_sail_man], [9, :fore_sail_man],
      [10, :steerman], [11, :steerman]
    ]
    assert_equal expected, assignments
  end
end
