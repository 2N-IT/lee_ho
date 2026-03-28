require_relative "../../test_helper"

class MotivateCrewHandlerTest < Minitest::Test
  include TestSupport

  def setup
    @rng = build_deterministic_rng
    @boat = LeeHo::Domain::Aggregates::Boat.build(rng: @rng)
    @handler = LeeHo::Application::CommandHandlers::MotivateCrewHandler.new(boat: @boat)
  end

  def test_motivate_restores_morale
    # Drain steerman's morale
    3.times do
      @boat.steerman.execute_order { LeeHo::Domain::ValueObjects::CommandResult.success("ok") }
    end
    assert_equal 2, @boat.steerman.morale.to_i

    command = LeeHo::Application::Commands::MotivateCrewCommand.new(crew_role: :steerman)
    result = @handler.call(command)

    assert result.success?
    assert_equal 5, @boat.steerman.morale.to_i
  end

  def test_unknown_role_returns_failure
    command = LeeHo::Application::Commands::MotivateCrewCommand.new(crew_role: :pirate)
    result = @handler.call(command)
    assert result.failure?
  end
end
