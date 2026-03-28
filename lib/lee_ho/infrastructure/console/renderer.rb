require_relative "../../domain/events/maneuver_step_completed"
require_relative "../../domain/events/crew_did_not_hear"
require_relative "../../domain/events/morale_too_low"
require_relative "../../domain/events/kausza_broken"
require_relative "../../domain/events/tack_completed"
require_relative "../../domain/events/game_won"

module LeeHo
  module Infrastructure
    module Console
      class Renderer
        SEPARATOR = "\e[2m#{"=" * 50}\e[0m"
        THIN_SEP  = "\e[2m#{"-" * 50}\e[0m"

        def render_welcome
          <<~TEXT

            #{SEPARATOR}
              \e[1mLEE HO!\e[0m  A Sailing Tack Simulator
            #{SEPARATOR}

            You are the \e[1mSkipper\e[0m. Command your crew through
            10 successful tacks to reach port safely.

            \e[4mYour crew:\e[0m
              \e[1mSteerman\e[0m        controls the helm
              \e[1mFore Sail Man\e[0m   manages the jib sheets
              \e[1mMain Sail Man\e[0m   manages the mainsail
              \e[1mMizzen Sail Man\e[0m manages the mizzen

            \e[2mCommands: status | help | quit\e[0m

            #{SEPARATOR}
          TEXT
        end

        def render_tack_start(tack_number, total)
          bar = progress_bar(tack_number, total)
          <<~TEXT

            #{THIN_SEP}
              \e[1mTACK #{tack_number} of #{total}\e[0m  #{bar}
            #{THIN_SEP}
          TEXT
        end

        def render_step_prompt(step)
          hint = command_hint(step)
          <<~TEXT

            \e[1m  [#{step.number}/11]\e[0m #{step.description}
            \e[2m         hint: #{hint}\e[0m
          TEXT
        end

        def render_command_prompt(_step)
          "  \e[33m>\e[0m "
        end

        def render_result(result)
          if result.success?
            "  \e[32m\u2713\e[0m #{result.message}"
          else
            "  \e[31m\u2717\e[0m #{result.message}"
          end
        end

        def render_event(event)
          case event
          when Domain::Events::TackCompleted
            "\n  \e[32m\u2714 Tack #{event.tack_number} completed successfully!\e[0m\n"
          when Domain::Events::GameWon
            <<~TEXT

              #{SEPARATOR}
                \e[1;32mVICTORY!\e[0m All #{event.total_tacks} tacks completed!
              #{SEPARATOR}
            TEXT
          else
            event.to_s
          end
        end

        def render_confirm(message)
          "  \e[33m?\e[0m #{message} \e[2m(y/n)\e[0m: "
        end

        def render_easter_egg_intro
          <<~TEXT

            #{SEPARATOR}
              The wind dies down. Land ahead!
              Your crew has earned a rest.
              Sailing into port...
            #{SEPARATOR}

            The harbor tavern awaits. What'll it be?
          TEXT
        end

        def render_drink_menu
          "    1. Mulled wine (grzaniec)\n" \
          "    2. Hot tea with rum\n" \
          "    3. Hot coffee\n" \
          "  Your choice (1-3): "
        end

        def render_easter_egg_outro(choice)
          drink = case choice
                  when "1" then "mulled wine"
                  when "2" then "hot tea with rum"
                  when "3" then "hot coffee"
                  else "a mysterious beverage"
                  end

          <<~TEXT

            #{SEPARATOR}
              The crew gathers around the tavern fire,
              warming their hands on mugs of #{drink}.

              "To the sea!" raises the Steerman.
              "To the sea!" echoes the crew.

              Fair winds and following seas, Skipper.
            #{SEPARATOR}
          TEXT
        end

        def render_status(boat_status, crew_status)
          lines = ["\n  #{THIN_SEP}"]
          lines << "  \e[1mHelm:\e[0m #{boat_status[:steer]}"
          lines << ""
          lines << "  \e[1mSails:\e[0m"
          boat_status[:sails].each do |sail|
            icon = sail[:broken] ? "\e[31m\u2717\e[0m" : "\e[32m\u2713\e[0m"
            lines << "    #{icon} #{sail[:name]}  \e[2mstate:\e[0m #{sail[:state]}  \e[2mwear:\e[0m #{sail[:wear]}"
          end
          lines << ""
          lines << "  \e[1mCrew:\e[0m"
          crew_status.each do |member|
            bar = morale_bar(member[:morale])
            lines << "    #{member[:name]}  #{bar}"
          end
          lines << "  #{THIN_SEP}"
          lines << ""
          lines.join("\n")
        end

        private

        def progress_bar(current, total)
          filled = current - 1
          empty = total - filled
          "\e[32m#{"=" * filled}\e[0m\e[2m#{"-" * empty}\e[0m [#{current}/#{total}]"
        end

        def morale_bar(value)
          color = value >= 3 ? "32" : value >= 2 ? "33" : "31"
          "\e[#{color}m#{"*" * value}\e[2m#{"." * (5 - value)}\e[0m #{value}/5"
        end

        def command_hint(step)
          case step.action
          when :ready_about       then "ready about"
          when :turn_right        then "helm starboard"
          when :haul_mizzen       then "haul mizzen"
          when :release_left_jib  then "release left jib"
          when :release_mainsail  then "release mainsail"
          when :release_mizzen    then "release mizzen"
          when :haul_mainsail     then "haul mainsail"
          when :haul_right_jib    then "haul right jib"
          when :center_helm       then "helm amidships"
          when :steady            then "steady"
          end
        end
      end
    end
  end
end
