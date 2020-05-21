module Mainsail
  class ManMoraleError < StandardError; end
  class Man < CrewMember # how about composition over inheritance? Should we always push it?

    def haul
      if morale >= assigned_to.MORALE_NEEDED
        puts "#{name}: Jest grota szot wybierz!"
        Mainsail::Haul.call(assigned_to)
      else
        raise ManMoraleError
      end
    end

    def loose
      if morale >= assigned_to.MORALE_NEEDED
        puts "#{name}: Jest grota szot luz!"
        Mainsail::Loose.call(assigned_to)
      else
        raise ManMoraleError
      end
    end
  end
end