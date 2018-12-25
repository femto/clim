require "./sub_command_alias"

{% begin %}
{%
  main_help_message = <<-HELP_MESSAGE

                        Command Line Interface Tool.

                        Usage:

                          main_command_of_clim_library [options] [arguments]

                        Options:

                          --help                           Show this help.

                        Sub Commands:

                          sub_command_1, alias_sub_command_1                               Command Line Interface Tool.
                          sub_command_2, alias_sub_command_2, alias_sub_command_2_second   Command Line Interface Tool.


                      HELP_MESSAGE

  sub_1_help_message = <<-HELP_MESSAGE

                         Command Line Interface Tool.

                         Usage:

                           sub_command_1 [options] [arguments]

                         Options:

                           -a ARG, --array=ARG              Option test. [type:Array(String)] [default:[\"default string\"]]
                           --help                           Show this help.

                         Sub Commands:

                           sub_sub_command_1   Command Line Interface Tool.


                       HELP_MESSAGE

  sub_sub_1_help_message = <<-HELP_MESSAGE

                             Command Line Interface Tool.

                             Usage:

                               sub_sub_command_1 [options] [arguments]

                             Options:

                               -b, --bool                       Bool test. [type:Bool]
                               --help                           Show this help.


                           HELP_MESSAGE

  sub_2_help_message = <<-HELP_MESSAGE

                         Command Line Interface Tool.

                         Usage:

                           sub_command_2 [options] [arguments]

                         Options:

                           --help                           Show this help.


                       HELP_MESSAGE
%}

spec_for_alias_name(
  spec_class_name: SubCommand2WithAliasName,
  spec_cases: [
    # sub_command_2
    {
      argv:        ["sub_command_2"],
      expect_help: {{sub_2_help_message}},
      expect_args: [] of String,
    },
    {
      argv:        ["alias_sub_command_2"],
      expect_help: {{sub_2_help_message}},
      expect_args: [] of String,
    },
    {
      argv:        ["alias_sub_command_2_second"],
      expect_help: {{sub_2_help_message}},
      expect_args: [] of String,
    },
    {
      argv:        ["sub_command_2", "arg1"],
      expect_help: {{sub_2_help_message}},
      expect_args: ["arg1"],
    },
    {
      argv:        ["alias_sub_command_2", "arg1"],
      expect_help: {{sub_2_help_message}},
      expect_args: ["arg1"],
    },
    {
      argv:        ["alias_sub_command_2_second", "arg1"],
      expect_help: {{sub_2_help_message}},
      expect_args: ["arg1"],
    },
    {
      argv:        ["sub_command_2", "arg1", "arg2"],
      expect_help: {{sub_2_help_message}},
      expect_args: ["arg1", "arg2"],
    },
    {
      argv:        ["alias_sub_command_2", "arg1", "arg2"],
      expect_help: {{sub_2_help_message}},
      expect_args: ["arg1", "arg2"],
    },
    {
      argv:        ["alias_sub_command_2_second", "arg1", "arg2"],
      expect_help: {{sub_2_help_message}},
      expect_args: ["arg1", "arg2"],
    },
    {
      argv:        ["sub_command_2", "arg1", "arg2", "arg3"],
      expect_help: {{sub_2_help_message}},
      expect_args: ["arg1", "arg2", "arg3"],
    },
    {
      argv:        ["alias_sub_command_2", "arg1", "arg2", "arg3"],
      expect_help: {{sub_2_help_message}},
      expect_args: ["arg1", "arg2", "arg3"],
    },
    {
      argv:        ["alias_sub_command_2_second", "arg1", "arg2", "arg3"],
      expect_help: {{sub_2_help_message}},
      expect_args: ["arg1", "arg2", "arg3"],
    },
    {
      argv:              ["sub_command_2", "--help", "-ignore-option"],
      exception_message: "Undefined option. \"-ignore-option\"",
    },
    {
      argv:              ["alias_sub_command_2", "--help", "-ignore-option"],
      exception_message: "Undefined option. \"-ignore-option\"",
    },
    {
      argv:              ["alias_sub_command_2_second", "--help", "-ignore-option"],
      exception_message: "Undefined option. \"-ignore-option\"",
    },
    {
      argv:              ["sub_command_2", "-ignore-option", "--help"],
      exception_message: "Undefined option. \"-ignore-option\"",
    },
    {
      argv:              ["alias_sub_command_2", "-ignore-option", "--help"],
      exception_message: "Undefined option. \"-ignore-option\"",
    },
    {
      argv:              ["alias_sub_command_2_second", "-ignore-option", "--help"],
      exception_message: "Undefined option. \"-ignore-option\"",
    },
    {
      argv:              ["sub_command_2", "-m"],
      exception_message: "Undefined option. \"-m\"",
    },
    {
      argv:              ["alias_sub_command_2", "-m"],
      exception_message: "Undefined option. \"-m\"",
    },
    {
      argv:              ["alias_sub_command_2_second", "-m"],
      exception_message: "Undefined option. \"-m\"",
    },
    {
      argv:              ["sub_command_2", "--missing-option"],
      exception_message: "Undefined option. \"--missing-option\"",
    },
    {
      argv:              ["alias_sub_command_2", "--missing-option"],
      exception_message: "Undefined option. \"--missing-option\"",
    },
    {
      argv:              ["alias_sub_command_2_second", "--missing-option"],
      exception_message: "Undefined option. \"--missing-option\"",
    },
    {
      argv:              ["sub_command_2", "-m", "arg1"],
      exception_message: "Undefined option. \"-m\"",
    },
    {
      argv:              ["alias_sub_command_2", "-m", "arg1"],
      exception_message: "Undefined option. \"-m\"",
    },
    {
      argv:              ["alias_sub_command_2_second", "-m", "arg1"],
      exception_message: "Undefined option. \"-m\"",
    },
    {
      argv:              ["sub_command_2", "arg1", "-m"],
      exception_message: "Undefined option. \"-m\"",
    },
    {
      argv:              ["alias_sub_command_2", "arg1", "-m"],
      exception_message: "Undefined option. \"-m\"",
    },
    {
      argv:              ["alias_sub_command_2_second", "arg1", "-m"],
      exception_message: "Undefined option. \"-m\"",
    },
    {
      argv:              ["sub_command_2", "-m", "-d"],
      exception_message: "Undefined option. \"-m\"",
    },
    {
      argv:              ["alias_sub_command_2", "-m", "-d"],
      exception_message: "Undefined option. \"-m\"",
    },
    {
      argv:              ["alias_sub_command_2_second", "-m", "-d"],
      exception_message: "Undefined option. \"-m\"",
    },
    {
      argv:        ["sub_command_2", "--help"],
      expect_help: {{sub_2_help_message}},
    },
    {
      argv:        ["alias_sub_command_2", "--help"],
      expect_help: {{sub_2_help_message}},
    },
    {
      argv:        ["alias_sub_command_2_second", "--help"],
      expect_help: {{sub_2_help_message}},
    },
    {
      argv:        ["sub_command_2", "--help", "ignore-arg"],
      expect_help: {{sub_2_help_message}},
    },
    {
      argv:        ["alias_sub_command_2", "--help", "ignore-arg"],
      expect_help: {{sub_2_help_message}},
    },
    {
      argv:        ["alias_sub_command_2_second", "--help", "ignore-arg"],
      expect_help: {{sub_2_help_message}},
    },
    {
      argv:        ["sub_command_2", "ignore-arg", "--help"],
      expect_help: {{sub_2_help_message}},
    },
    {
      argv:        ["alias_sub_command_2", "ignore-arg", "--help"],
      expect_help: {{sub_2_help_message}},
    },
    {
      argv:        ["alias_sub_command_2_second", "ignore-arg", "--help"],
      expect_help: {{sub_2_help_message}},
    },
  ]
)
{% end %}