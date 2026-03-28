require_relative "lib/lee_ho"

rng = LeeHo::Infrastructure::Random::Rng.new
boat = LeeHo::Domain::Aggregates::Boat.build(rng: rng)
ui = LeeHo::Infrastructure::Console::UI.new

game = LeeHo::Application::GameService.new(boat: boat, ui_port: ui)
ui.attach(game)

game.run
