require "./clim/*"

class Clim
  include Types

  macro main(&block)
    main_command do
      {{ yield }}
    end
  end

  macro main_command(&block)

    Clim::Command.command "main_command_of_clim_library" do
      {{ yield }}
    end

    def self.command
      Command_Main_command_of_clim_library.create
    end

    def self.start_parse(argv, io : IO = STDOUT)
      selected_command = command.parse(argv)
      raise "aaa" unless selected_command.responds_to?(:run)
      selected_command.run(io)
    end

    def self.start(argv, io : IO = STDOUT)
      start_parse(argv, io)
    rescue ex : ClimException
      puts "ERROR: #{ex.message}"
    rescue ex : ClimInvalidOptionException | ClimInvalidTypeCastException
      puts "ERROR: #{ex.message}"
      puts ""
      puts "Please see the `--help`."
    end

    {% if @type.constants.map(&.id.stringify).includes?("Command_Main_command_of_clim_library") %}
      {% raise "Main command is already defined." %}
    {% end %}

  end
end
