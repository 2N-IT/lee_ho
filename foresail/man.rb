module Foresail
  class ManMoraleError < StandardError; end
  class Man < CrewMember # how about composition over inheritance? Should we always push it?

    def haul
      raise Foresail::ManMoraleError if morale >= assigned_to::MORALE_NEEDED
      puts "#{name}: Jest foka szot wybierz!"
      morale -= 1
      Foresail::Haul.call(assigned_to)
    end

    def loose
      raise Foresail::ManMoraleError if morale >= assigned_to::MORALE_NEEDED
      puts "#{name}: Jest foka szot luz!"
      Foresail::Loose.call(assigned_to)
    end
  end
end
