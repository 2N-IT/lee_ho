require_relative "../domain/aggregates/boat"
require_relative "../domain/services/tack_sequence"
require_relative "../domain/events/tack_completed"
require_relative "../domain/events/game_won"
require_relative "../domain/events/crew_did_not_hear"
require_relative "../domain/events/morale_too_low"
require_relative "../domain/events/kausza_broken"
require_relative "commands/execute_maneuver_step_command"
require_relative "commands/motivate_crew_command"
require_relative "commands/repair_sail_command"
require_relative "command_handlers/execute_maneuver_step_handler"
require_relative "command_handlers/motivate_crew_handler"
require_relative "command_handlers/repair_sail_handler"
require_relative "queries/boat_status_query"
require_relative "queries/crew_status_query"
require_relative "queries/maneuver_progress_query"

module LeeHo
  module Application
    class GameService
      TOTAL_TACKS = 10

      attr_reader :boat, :tack_number

      def initialize(boat:, ui_port:)
        @boat = boat
        @ui_port = ui_port
        @tack_number = 0
        @step_handler = CommandHandlers::ExecuteManeuverStepHandler.new(boat: boat)
        @motivate_handler = CommandHandlers::MotivateCrewHandler.new(boat: boat)
        @repair_handler = CommandHandlers::RepairSailHandler.new(boat: boat)
      end

      def run
        @ui_port.display_welcome

        while @tack_number < TOTAL_TACKS
          @tack_number += 1
          @ui_port.display_tack_start(@tack_number, TOTAL_TACKS)
          execute_tack
          @ui_port.display_event(Domain::Events::TackCompleted.new(tack_number: @tack_number))
        end

        @ui_port.display_event(Domain::Events::GameWon.new(total_tacks: TOTAL_TACKS))
        run_easter_egg
      end

      def boat_status
        Queries::BoatStatusQuery.new(boat: @boat).call
      end

      def crew_status
        Queries::CrewStatusQuery.new(boat: @boat).call
      end

      def maneuver_progress(current_step)
        Queries::ManeuverProgressQuery.new(tack_number: @tack_number, current_step: current_step).call
      end

      private

      def execute_tack
        Domain::Services::TackSequence.steps.each do |step|
          execute_step_with_recovery(step)
        end
      end

      def execute_step_with_recovery(step)
        @ui_port.display_step_prompt(step)

        loop do
          @ui_port.wait_for_command(step)

          command = Commands::ExecuteManeuverStepCommand.new(step_number: step.number)
          result = @step_handler.call(command)

          if result.success?
            @ui_port.display_result(result)
            break
          end

          handle_failure(result, step)
        end
      end

      def handle_failure(result, step)
        @ui_port.display_result(result)

        result.events.each do |event|
          case event
          when Domain::Events::CrewDidNotHear
            handle_did_not_hear(event)
          when Domain::Events::MoraleTooLow
            handle_morale_too_low(step)
          when Domain::Events::KauszaBroken
            handle_kausza_broken(step)
          end
        end
      end

      def handle_did_not_hear(event)
        if @ui_port.confirm?("#{event.crew_role} didn't hear! Repeat the command?")
          # Loop will retry
        end
      end

      def handle_morale_too_low(step)
        if @ui_port.confirm?("Skipper, motivate #{step.crew_role}?")
          command = Commands::MotivateCrewCommand.new(crew_role: step.crew_role)
          result = @motivate_handler.call(command)
          @ui_port.display_result(result)
        end
      end

      def handle_kausza_broken(step)
        if @ui_port.confirm?("Bosun, repair the sail?")
          command = Commands::RepairSailCommand.new(sail_action: step.action)
          result = @repair_handler.call(command)
          @ui_port.display_result(result)
        end
      end

      def run_easter_egg
        @ui_port.display_easter_egg_intro
        choice = @ui_port.choose_drink
        @ui_port.display_easter_egg_outro(choice)
      end
    end
  end
end
