require_relative "../../test_helper"

class BoatTest < Minitest::Test
  include TestSupport

  def setup
    @rng = build_deterministic_rng
    @boat = LeeHo::Domain::Aggregates::Boat.build(rng: @rng)
  end

  def test_build_creates_all_crew
    assert_equal 4, @boat.all_crew.length
    assert_instance_of LeeHo::Domain::Entities::Steerman, @boat.steerman
    assert_instance_of LeeHo::Domain::Entities::ForeSailMan, @boat.fore_sail_man
    assert_instance_of LeeHo::Domain::Entities::MainSailMan, @boat.main_sail_man
    assert_instance_of LeeHo::Domain::Entities::MizzenSailMan, @boat.mizzen_sail_man
  end

  def test_build_creates_all_sails
    assert_equal 4, @boat.all_sails.length
    assert_instance_of LeeHo::Domain::Entities::JibSheet, @boat.left_jib_sheet
    assert_instance_of LeeHo::Domain::Entities::JibSheet, @boat.right_jib_sheet
    assert_instance_of LeeHo::Domain::Entities::Mainsail, @boat.mainsail
    assert_instance_of LeeHo::Domain::Entities::MizzenSail, @boat.mizzen_sail
  end

  def test_build_creates_steer
    assert_instance_of LeeHo::Domain::Entities::Steer, @boat.steer
  end

  def test_execute_ready_about_step
    step = LeeHo::Domain::Services::TackSequence.steps[0]
    result = @boat.execute_step(step)
    assert result.success?
    assert_match(/lee ho/i, result.message)
  end

  def test_execute_turn_right_step
    step = LeeHo::Domain::Services::TackSequence.steps[1]
    result = @boat.execute_step(step)
    assert result.success?
    assert @boat.steer.position.right?
  end

  def test_crew_member_for_returns_correct_member
    assert_equal @boat.steerman, @boat.crew_member_for(:steerman)
    assert_equal @boat.fore_sail_man, @boat.crew_member_for(:fore_sail_man)
    assert_equal @boat.main_sail_man, @boat.crew_member_for(:main_sail_man)
    assert_equal @boat.mizzen_sail_man, @boat.crew_member_for(:mizzen_sail_man)
  end

  def test_full_tack_sequence_succeeds
    LeeHo::Domain::Services::TackSequence.steps.each do |step|
      result = @boat.execute_step(step)
      assert result.success?, "Step #{step.number} (#{step.action}) failed: #{result.message}"
    end
  end
end
