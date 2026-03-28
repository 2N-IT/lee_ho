module LeeHo
  module Infrastructure
    module Console
      class InputParser
        COMMAND_MAP = {
          ready_about:      ["ready about", "lee ho", "ready", "about"],
          turn_right:       ["helm starboard", "starboard", "helm right", "turn right"],
          haul_mizzen:      ["haul mizzen", "mizzen haul"],
          release_left_jib: ["release left jib", "left jib release", "release jib left"],
          release_mainsail: ["release mainsail", "release main", "mainsail release"],
          release_mizzen:   ["release mizzen", "mizzen release"],
          haul_mainsail:    ["haul mainsail", "haul main", "mainsail haul"],
          haul_right_jib:   ["haul right jib", "right jib haul", "haul jib right"],
          center_helm:      ["helm amidships", "center helm", "helm center", "amidships"],
          steady:           ["steady", "steady as she goes", "hold course"]
        }.freeze

        META_COMMANDS = %w[status help quit].freeze

        def parse(input, expected_action:)
          normalized = input.strip.downcase

          return :status if normalized == "status"
          return :help if normalized == "help"
          return :quit if normalized == "quit"

          matches_expected?(normalized, expected_action) ? :execute : :invalid
        end

        private

        def matches_expected?(input, expected_action)
          accepted = COMMAND_MAP.fetch(expected_action, [])
          accepted.any? { |cmd| input == cmd }
        end
      end
    end
  end
end
