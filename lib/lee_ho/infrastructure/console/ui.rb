require_relative "renderer"
require_relative "input_parser"

module LeeHo
  module Infrastructure
    module Console
      class UI
        def initialize(input: $stdin, output: $stdout)
          @input = input
          @output = output
          @renderer = Renderer.new
          @parser = InputParser.new
          @game_service = nil
        end

        def attach(game_service)
          @game_service = game_service
        end

        def display_welcome
          print @renderer.render_welcome
        end

        def display_tack_start(tack_number, total)
          print @renderer.render_tack_start(tack_number, total)
        end

        def display_step_prompt(step)
          print @renderer.render_step_prompt(step)
        end

        def wait_for_command(step)
          loop do
            print @renderer.render_command_prompt(step)
            raw_input = read_input
            return if raw_input.nil?

            parsed = @parser.parse(raw_input, expected_action: step.action)

            case parsed
            when :execute
              return
            when :status
              display_status
            when :help
              display_help(step)
            when :quit
              print "\n  Abandoning ship? Fair winds, Skipper.\n"
              exit(0)
            when :invalid
              print "  Unrecognized command. Type 'help' for guidance.\n"
            end
          end
        end

        def display_result(result)
          puts @renderer.render_result(result)
        end

        def display_event(event)
          print @renderer.render_event(event)
        end

        def confirm?(message)
          print @renderer.render_confirm(message)
          answer = read_input
          answer&.strip&.downcase&.start_with?("y")
        end

        def display_easter_egg_intro
          print @renderer.render_easter_egg_intro
        end

        def choose_drink
          print @renderer.render_drink_menu
          choice = read_input
          choice&.strip || "1"
        end

        def display_easter_egg_outro(choice)
          print @renderer.render_easter_egg_outro(choice)
        end

        private

        def read_input
          @input.gets&.chomp
        end

        def display_status
          return unless @game_service

          boat_status = @game_service.boat_status
          crew_status = @game_service.crew_status
          print @renderer.render_status(boat_status, crew_status)
        end

        def display_help(step)
          print <<~HELP

            Available commands:
              Type the sailing command shown in the prompt.
              Example: "#{expected_command_hint(step)}"

              status - view boat and crew status
              help   - show this help message
              quit   - abandon ship

          HELP
        end

        def expected_command_hint(step)
          @renderer.send(:command_hint, step)
        end

        def print(text)
          @output.print(text)
        end

        def puts(text)
          @output.puts(text)
        end
      end
    end
  end
end
