require_relative "../../test_helper"

class InputParserTest < Minitest::Test
  def setup
    @parser = LeeHo::Infrastructure::Console::InputParser.new
  end

  def test_recognizes_ready_about
    assert_equal :execute, @parser.parse("ready about", expected_action: :ready_about)
  end

  def test_recognizes_lee_ho_alias
    assert_equal :execute, @parser.parse("lee ho", expected_action: :ready_about)
  end

  def test_recognizes_helm_starboard
    assert_equal :execute, @parser.parse("helm starboard", expected_action: :turn_right)
  end

  def test_recognizes_haul_mizzen
    assert_equal :execute, @parser.parse("haul mizzen", expected_action: :haul_mizzen)
  end

  def test_recognizes_status_command
    assert_equal :status, @parser.parse("status", expected_action: :turn_right)
  end

  def test_recognizes_help_command
    assert_equal :help, @parser.parse("help", expected_action: :turn_right)
  end

  def test_recognizes_quit_command
    assert_equal :quit, @parser.parse("quit", expected_action: :turn_right)
  end

  def test_invalid_command_returns_invalid
    assert_equal :invalid, @parser.parse("fly away", expected_action: :turn_right)
  end

  def test_case_insensitive
    assert_equal :execute, @parser.parse("Ready About", expected_action: :ready_about)
  end

  def test_trims_whitespace
    assert_equal :execute, @parser.parse("  ready about  ", expected_action: :ready_about)
  end

  def test_wrong_command_for_step_returns_invalid
    assert_equal :invalid, @parser.parse("haul mizzen", expected_action: :turn_right)
  end
end
