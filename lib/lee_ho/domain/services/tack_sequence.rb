module LeeHo
  module Domain
    module Services
      class TackSequence
        Step = Struct.new(:number, :crew_role, :action, :description, keyword_init: true)

        STEPS = [
          Step.new(number: 1,  crew_role: :all,             action: :ready_about,       description: "Ready about! Lee ho!"),
          Step.new(number: 2,  crew_role: :steerman,        action: :turn_right,        description: "Helm to starboard!"),
          Step.new(number: 3,  crew_role: :mizzen_sail_man, action: :haul_mizzen,       description: "Haul the mizzen sheet!"),
          Step.new(number: 4,  crew_role: :fore_sail_man,   action: :release_left_jib,  description: "Release the left jib sheet!"),
          Step.new(number: 5,  crew_role: :main_sail_man,   action: :release_mainsail,  description: "Release the main sheet!"),
          Step.new(number: 6,  crew_role: :mizzen_sail_man, action: :release_mizzen,    description: "Release the mizzen sheet!"),
          Step.new(number: 7,  crew_role: :mizzen_sail_man, action: :haul_mizzen,       description: "Haul the mizzen sheet!"),
          Step.new(number: 8,  crew_role: :main_sail_man,   action: :haul_mainsail,     description: "Haul the main sheet!"),
          Step.new(number: 9,  crew_role: :fore_sail_man,   action: :haul_right_jib,    description: "Haul the right jib sheet!"),
          Step.new(number: 10, crew_role: :steerman,        action: :center_helm,       description: "Helm amidships!"),
          Step.new(number: 11, crew_role: :steerman,        action: :steady,            description: "Steady as she goes!")
        ].each(&:freeze).freeze

        def self.steps
          STEPS
        end

        def self.step_count
          STEPS.length
        end
      end
    end
  end
end
