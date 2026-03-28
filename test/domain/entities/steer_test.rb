require_relative "../../test_helper"

class SteerTest < Minitest::Test
  def setup
    @steer = LeeHo::Domain::Entities::Steer.new
  end

  def test_initial_position_is_neutral
    assert @steer.position.neutral?
  end

  def test_turn_right
    result = @steer.turn(:right)
    assert result.success?
    assert @steer.position.right?
  end

  def test_turn_left
    result = @steer.turn(:left)
    assert result.success?
    assert @steer.position.left?
  end

  def test_center
    @steer.turn(:right)
    result = @steer.center!
    assert result.success?
    assert @steer.position.neutral?
  end

  def test_steady
    result = @steer.steady!
    assert result.success?
    assert_match(/steady/i, result.message)
  end
end
