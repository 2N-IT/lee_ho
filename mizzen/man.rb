module Mizzen
  class ManMoraleError < StandardError; end
  class Man < CrewMember # how about composition over inheritance? Should we always push it?

    def haul
      puts "#{name}: Jest bezana szot wybierz!"
      Mizzen::Haul.call(assigned_to)
    end

    def pull
      puts "#{name}: Jest bezana szot luz!"
      Mizzen::Loose.call(assigned_to)
    end
  end
end