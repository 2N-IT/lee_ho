require_relative "../../test_helper"

class ExecuteManeuverStepHandlerTest < Minitest::Test
  include TestSupport

  def setup
    @rng = build_deterministic_rng
    @boat = LeeHo::Domain::Aggregates::Boat.build(rng: @rng)
    @handler = LeeHo::Application::CommandHandlers::ExecuteManeuverStepHandler.new(boat: @boat)
  end

  def test_successful_step_returns_success_with_event
    command = LeeHo::Application::Commands::ExecuteManeuverStepCommand.new(step_number: 1)
    result = @handler.call(command)

    assert result.success?
    step_event = result.events.find { |e| e.is_a?(LeeHo::Domain::Events::ManeuverStepCompleted) }
    assert step_event
    assert_equal 1, step_event.step_number
  end

  def test_invalid_step_number_returns_failure
    command = LeeHo::Application::Commands::ExecuteManeuverStepCommand.new(step_number: 99)
    result = @handler.call(command)
    assert result.failure?
  end
end
