require_relative "../../test_helper"

class SteermanTest < Minitest::Test
  include TestSupport

  def test_morale_min_is_two
    assert_equal 2, LeeHo::Domain::Entities::Steerman::MORALE_MIN
  end

  def test_mishear_probability_is_twenty_percent
    assert_equal 0.20, LeeHo::Domain::Entities::Steerman::MISHEAR_PROBABILITY
  end

  def test_name
    rng = build_deterministic_rng
    checker = LeeHo::Domain::Services::MishearChecker.new(rng: rng)
    steerman = LeeHo::Domain::Entities::Steerman.new(mishear_checker: checker)
    assert_equal "Steerman", steerman.name
  end
end

class ForeSailManTest < Minitest::Test
  def test_morale_min_is_three
    assert_equal 3, LeeHo::Domain::Entities::ForeSailMan::MORALE_MIN
  end

  def test_mishear_probability_is_twenty_percent
    assert_equal 0.20, LeeHo::Domain::Entities::ForeSailMan::MISHEAR_PROBABILITY
  end
end

class MainSailManTest < Minitest::Test
  def test_morale_min_is_two
    assert_equal 2, LeeHo::Domain::Entities::MainSailMan::MORALE_MIN
  end
end

class MizzenSailManTest < Minitest::Test
  def test_morale_min_is_zero
    assert_equal 0, LeeHo::Domain::Entities::MizzenSailMan::MORALE_MIN
  end

  def test_mishear_probability_is_forty_percent
    assert_equal 0.40, LeeHo::Domain::Entities::MizzenSailMan::MISHEAR_PROBABILITY
  end
end
