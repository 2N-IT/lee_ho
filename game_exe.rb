$:.unshift(File.expand_path(File.dirname(__FILE__)))
require_relative 'lib/autoload'

boat = Boat.new

while result != :stop
  result = Skipper::LeeHo.call(boat)
end

Skipper::LeeHo.call(boat)
Skipper::LeeHo.call(boat)
Skipper::LeeHo.call(boat)
Skipper::LeeHo.call(boat)
Skipper::LeeHo.call(boat)
Skipper::LeeHo.call(boat)
Skipper::LeeHo.call(boat)
Skipper::LeeHo.call(boat)
Skipper::LeeHo.call(boat)
Skipper::LeeHo.call(boat)

