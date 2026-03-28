require_relative "../entities/steerman"
require_relative "../entities/fore_sail_man"
require_relative "../entities/main_sail_man"
require_relative "../entities/mizzen_sail_man"
require_relative "../entities/jib_sheet"
require_relative "../entities/mainsail"
require_relative "../entities/mizzen_sail"
require_relative "../entities/steer"
require_relative "../services/mishear_checker"
require_relative "../services/wear_calculator"

module LeeHo
  module Domain
    module Aggregates
      class Boat
        attr_reader :steerman, :fore_sail_man, :main_sail_man, :mizzen_sail_man,
                    :left_jib_sheet, :right_jib_sheet, :mainsail, :mizzen_sail, :steer

        def initialize(steerman:, fore_sail_man:, main_sail_man:, mizzen_sail_man:,
                       left_jib_sheet:, right_jib_sheet:, mainsail:, mizzen_sail:, steer:)
          @steerman = steerman
          @fore_sail_man = fore_sail_man
          @main_sail_man = main_sail_man
          @mizzen_sail_man = mizzen_sail_man
          @left_jib_sheet = left_jib_sheet
          @right_jib_sheet = right_jib_sheet
          @mainsail = mainsail
          @mizzen_sail = mizzen_sail
          @steer = steer
        end

        def self.build(rng:)
          mishear_checker = Services::MishearChecker.new(rng: rng)
          wear_calculator = Services::WearCalculator.new(rng: rng)

          new(
            steerman:        Entities::Steerman.new(mishear_checker: mishear_checker),
            fore_sail_man:   Entities::ForeSailMan.new(mishear_checker: mishear_checker),
            main_sail_man:   Entities::MainSailMan.new(mishear_checker: mishear_checker),
            mizzen_sail_man: Entities::MizzenSailMan.new(mishear_checker: mishear_checker),
            left_jib_sheet:  Entities::JibSheet.new(name: "Left Jib Sheet", wear_calculator: wear_calculator),
            right_jib_sheet: Entities::JibSheet.new(name: "Right Jib Sheet", wear_calculator: wear_calculator),
            mainsail:        Entities::Mainsail.new(name: "Mainsail", wear_calculator: wear_calculator),
            mizzen_sail:     Entities::MizzenSail.new(name: "Mizzen Sail", wear_calculator: wear_calculator),
            steer:           Entities::Steer.new
          )
        end

        def execute_step(step)
          case step.action
          when :ready_about
            ready_about
          when :turn_right
            steerman.execute_order { steer.turn(:right) }
          when :haul_mizzen
            mizzen_sail_man.execute_order { mizzen_sail.haul! }
          when :release_left_jib
            fore_sail_man.execute_order { left_jib_sheet.release! }
          when :release_mainsail
            main_sail_man.execute_order { mainsail.release! }
          when :release_mizzen
            mizzen_sail_man.execute_order { mizzen_sail.release! }
          when :haul_mainsail
            main_sail_man.execute_order { mainsail.haul! }
          when :haul_right_jib
            fore_sail_man.execute_order { right_jib_sheet.haul! }
          when :center_helm
            steerman.execute_order { steer.center! }
          when :steady
            steerman.execute_order { steer.steady! }
          end
        end

        def crew_member_for(role)
          case role
          when :steerman        then steerman
          when :fore_sail_man   then fore_sail_man
          when :main_sail_man   then main_sail_man
          when :mizzen_sail_man then mizzen_sail_man
          end
        end

        def sail_for_action(action)
          case action
          when :haul_mizzen, :release_mizzen then mizzen_sail
          when :release_left_jib             then left_jib_sheet
          when :haul_right_jib               then right_jib_sheet
          when :release_mainsail, :haul_mainsail then mainsail
          end
        end

        def all_crew
          [steerman, fore_sail_man, main_sail_man, mizzen_sail_man]
        end

        def all_sails
          [left_jib_sheet, right_jib_sheet, mainsail, mizzen_sail]
        end

        private

        def ready_about
          ValueObjects::CommandResult.success("All hands ready about! Lee ho!")
        end
      end
    end
  end
end
