require "./../../../../src/clim"

class MyCli < Clim
  main_command do
    custom_help do |desc, usage, options_help, sub_commands|
      <<-MY_HELP
      command description: \#{desc}
      command usage: \#{usage}

      options:
      \#{options_help}

      sub_commands:
      \#{sub_commands}
      MY_HELP
    end
    run do |opts, args|
    end
    sub_command "sub_command" do
      desc "sub_comand."
      option "-n NUM", type: Int32, desc: "Number.", default: 0
      run do |opts, args|
      end
      sub_command "sub_sub_command" do
        desc "sub_sub_comand description."
        option "-p PASSWORD", type: String, desc: "Password.", required: true
        run do |opts, args|
        end
      end
    end
  end
end

MyCli.start(ARGV)