require "../../dsl_spec"

{% begin %}
{%
  main_help_message = <<-HELP_MESSAGE
                      command description: Command Line Interface Tool.
                      command usage: main_command_of_clim_library [options] [arguments]

                      options:
                          --uint8=VALUE                    Option description. [type:UInt8]
                          --uint16=VALUE                   Option description. [type:UInt16]
                          --help                           Show this help.

                      HELP_MESSAGE
%}

spec(
  spec_class_name: OptionTypeSpec,
  spec_dsl_lines: [
    <<-CUSTOM_HELP
    custom_help do |desc, usage, options_help|
      <<-MY_HELP
      command description: \#{desc}
      command usage: \#{usage}

      options:
      \#{options_help}
      MY_HELP
    end
    CUSTOM_HELP,
    "option \"--uint8=VALUE\", type: UInt8",
    "option \"--uint16=VALUE\", type: UInt16",
  ],
  spec_desc: "option type spec,",
  spec_cases: [
    {
      argv:        ["--help"],
      expect_help: {{main_help_message}},
    },
  ]
)
{% end %}
