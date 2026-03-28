require_relative "../../test_helper"

class MishearCheckerTest < Minitest::Test
  include TestSupport

  def test_heard_when_rng_returns_false
    rng = build_deterministic_rng
    checker = LeeHo::Domain::Services::MishearChecker.new(rng: rng)
    assert checker.heard?(0.20)
  end

  def test_not_heard_when_rng_returns_true
    rng = build_always_failing_rng
    checker = LeeHo::Domain::Services::MishearChecker.new(rng: rng)
    refute checker.heard?(0.20)
  end
end
