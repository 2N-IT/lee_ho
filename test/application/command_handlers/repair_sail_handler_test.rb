require_relative "../../test_helper"

class RepairSailHandlerTest < Minitest::Test
  include TestSupport

  def setup
    @rng = build_deterministic_rng
    @boat = LeeHo::Domain::Aggregates::Boat.build(rng: @rng)
    @handler = LeeHo::Application::CommandHandlers::RepairSailHandler.new(boat: @boat)
  end

  def test_repair_fixes_broken_sail
    # Break the mainsail by wearing it out
    10.times do
      @boat.mainsail.haul!
      @boat.mainsail.release! unless @boat.mainsail.broken?
    end
    assert @boat.mainsail.broken?

    command = LeeHo::Application::Commands::RepairSailCommand.new(sail_action: :haul_mainsail)
    result = @handler.call(command)

    assert result.success?
    refute @boat.mainsail.broken?
  end

  def test_unknown_action_returns_failure
    command = LeeHo::Application::Commands::RepairSailCommand.new(sail_action: :haul_spinnaker)
    result = @handler.call(command)
    assert result.failure?
  end
end
