require_relative "../../test_helper"

class RendererTest < Minitest::Test
  def setup
    @renderer = LeeHo::Infrastructure::Console::Renderer.new
  end

  def test_render_welcome_includes_game_title
    assert_match(/LEE HO/, @renderer.render_welcome)
  end

  def test_render_tack_start_includes_number
    output = @renderer.render_tack_start(3, 10)
    assert_match(/TACK 3 of 10/, output)
  end

  def test_render_result_success
    result = LeeHo::Domain::ValueObjects::CommandResult.success("Helm right!")
    output = @renderer.render_result(result)
    assert_match(/Helm right!/, output)
  end

  def test_render_result_failure
    result = LeeHo::Domain::ValueObjects::CommandResult.failure("Kausza broken!")
    output = @renderer.render_result(result)
    assert_match(/Kausza broken!/, output)
  end

  def test_render_event_tack_completed
    event = LeeHo::Domain::Events::TackCompleted.new(tack_number: 5)
    output = @renderer.render_event(event)
    assert_match(/Tack 5 completed/, output)
  end

  def test_render_event_game_won
    event = LeeHo::Domain::Events::GameWon.new(total_tacks: 10)
    output = @renderer.render_event(event)
    assert_match(/VICTORY/, output)
  end

  def test_render_status
    boat_status = {
      steer: "neutral",
      sails: [
        { name: "Mainsail", state: "idle", wear: "0/10", broken: false }
      ]
    }
    crew_status = [
      { name: "Steerman", morale: 5 }
    ]
    output = @renderer.render_status(boat_status, crew_status)
    assert_match(/Mainsail/, output)
    assert_match(/Steerman/, output)
    assert_match(/5\/5/, output)
  end

  def test_render_easter_egg_drinks
    assert_match(/mulled wine/, @renderer.render_easter_egg_outro("1"))
    assert_match(/tea with rum/, @renderer.render_easter_egg_outro("2"))
    assert_match(/coffee/, @renderer.render_easter_egg_outro("3"))
  end
end
