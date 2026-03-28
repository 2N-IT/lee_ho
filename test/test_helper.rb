require "minitest/autorun"
require_relative "../lib/lee_ho"

module TestSupport
  def build_deterministic_rng(always_hear: true, never_break: true)
    rng = LeeHo::Infrastructure::Random::Rng.new(seed: 42)

    if always_hear && never_break
      # Override chance? to always return false (no mishear, no break)
      rng.define_singleton_method(:chance?) { |_prob| false }
    end

    rng
  end

  def build_always_failing_rng
    rng = LeeHo::Infrastructure::Random::Rng.new(seed: 42)
    rng.define_singleton_method(:chance?) { |_prob| true }
    rng
  end
end
