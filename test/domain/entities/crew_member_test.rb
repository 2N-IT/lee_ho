require_relative "../../test_helper"

class CrewMemberTest < Minitest::Test
  include TestSupport

  def setup
    @rng = build_deterministic_rng
    @mishear_checker = LeeHo::Domain::Services::MishearChecker.new(rng: @rng)
  end

  def test_initial_morale_is_five
    member = LeeHo::Domain::Entities::Steerman.new(mishear_checker: @mishear_checker)
    assert_equal 5, member.morale.to_i
  end

  def test_execute_order_decrements_morale
    member = LeeHo::Domain::Entities::Steerman.new(mishear_checker: @mishear_checker)
    member.execute_order { LeeHo::Domain::ValueObjects::CommandResult.success("done") }
    assert_equal 4, member.morale.to_i
  end

  def test_execute_order_returns_action_result
    member = LeeHo::Domain::Entities::Steerman.new(mishear_checker: @mishear_checker)
    result = member.execute_order { LeeHo::Domain::ValueObjects::CommandResult.success("test") }
    assert result.success?
  end

  def test_morale_too_low_fails
    member = LeeHo::Domain::Entities::Steerman.new(mishear_checker: @mishear_checker)
    4.times { member.execute_order { LeeHo::Domain::ValueObjects::CommandResult.success("ok") } }
    # Morale is now 1, Steerman needs >= 2
    result = member.execute_order { LeeHo::Domain::ValueObjects::CommandResult.success("ok") }
    assert result.failure?
    morale_event = result.events.find { |e| e.is_a?(LeeHo::Domain::Events::MoraleTooLow) }
    assert morale_event
  end

  def test_motivate_resets_morale
    member = LeeHo::Domain::Entities::Steerman.new(mishear_checker: @mishear_checker)
    3.times { member.execute_order { LeeHo::Domain::ValueObjects::CommandResult.success("ok") } }
    member.motivate!
    assert_equal 5, member.morale.to_i
  end

  def test_mishear_returns_failure_with_event
    rng = build_always_failing_rng
    mishear_checker = LeeHo::Domain::Services::MishearChecker.new(rng: rng)
    member = LeeHo::Domain::Entities::Steerman.new(mishear_checker: mishear_checker)

    result = member.execute_order { LeeHo::Domain::ValueObjects::CommandResult.success("ok") }
    assert result.failure?
    hear_event = result.events.find { |e| e.is_a?(LeeHo::Domain::Events::CrewDidNotHear) }
    assert hear_event
  end

  def test_mishear_does_not_decrement_morale
    rng = build_always_failing_rng
    mishear_checker = LeeHo::Domain::Services::MishearChecker.new(rng: rng)
    member = LeeHo::Domain::Entities::Steerman.new(mishear_checker: mishear_checker)

    member.execute_order { LeeHo::Domain::ValueObjects::CommandResult.success("ok") }
    assert_equal 5, member.morale.to_i
  end
end
