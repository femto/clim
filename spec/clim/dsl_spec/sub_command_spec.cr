require "./../../spec_helper"

class SpecSubCommandOnly < Clim
  main_command
  run do |opts, args|
    raise "Main command is not target for spec."
  end

  sub do
    command "sub_command"
    run do |opts, args|
    end
  end
end

describe "sub command only." do
  describe "returns main command help." do
    [
      {
        argv: %w(--help),
      },
      {
        argv: %w(--help ignore-arg),
      },
      {
        argv: %w(ignore-arg --help),
      },
      {
        argv: %w(--help -ignore-option),
      },
      {
        argv: %w(-ignore-option --help),
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        run_proc_opts, run_proc_args = SpecSubCommandOnly.run_proc_arguments(spec_case[:argv])
        run_proc_opts["help"].should eq(
          <<-HELP_MESSAGE

            Command Line Interface Tool.

            Usage:

              main_command [options] [arguments]

            Options:

              --help                           Show this help.

            Sub Commands:

              sub_command   Command Line Interface Tool.


          HELP_MESSAGE
        )
      end
    end
  end
  describe "returns sub command help." do
    [
      {
        argv: %w(sub_command --help),
      },
      {
        argv: %w(sub_command --help ignore-arg),
      },
      {
        argv: %w(sub_command ignore-arg --help),
      },
      {
        argv: %w(sub_command --help -ignore-option),
      },
      {
        argv: %w(sub_command -ignore-option --help),
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        run_proc_opts, run_proc_args = SpecSubCommandOnly.run_proc_arguments(spec_case[:argv])
        run_proc_opts["help"].should eq(
          <<-HELP_MESSAGE

            Command Line Interface Tool.

            Usage:

              sub_command [options] [arguments]

            Options:

              --help                           Show this help.


          HELP_MESSAGE
        )
      end
    end
  end
  describe "returns opts and args when passing argv." do
    [
      {
        argv:        %w(sub_command),
        expect_opts: create_values,
        expect_args: [] of String,
      },
      {
        argv:        %w(sub_command arg1),
        expect_opts: create_values,
        expect_args: ["arg1"],
      },
      {
        argv:        %w(sub_command arg1 arg2),
        expect_opts: create_values,
        expect_args: ["arg1", "arg2"],
      },
      {
        argv:        %w(sub_command arg1 arg2 arg3),
        expect_opts: create_values,
        expect_args: ["arg1", "arg2", "arg3"],
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        run_proc_opts, run_proc_args = SpecSubCommandOnly.run_proc_arguments(spec_case[:argv])
        run_proc_opts.delete("help")
        run_proc_opts.should eq(spec_case[:expect_opts])
        run_proc_args.should eq(spec_case[:expect_args])
      end
    end
  end
  describe "raises Exception when passing invalid argv to main command." do
    [
      {
        argv:              %w(sub_command -m),
        exception_message: "Undefined option. \"-m\"",
      },
      {
        argv:              %w(sub_command --missing-option),
        exception_message: "Undefined option. \"--missing-option\"",
      },
      {
        argv:              %w(sub_command -m arg1),
        exception_message: "Undefined option. \"-m\"",
      },
      {
        argv:              %w(sub_command arg1 -m),
        exception_message: "Undefined option. \"-m\"",
      },
      {
        argv:              %w(sub_command -m -d),
        exception_message: "Undefined option. \"-m\"",
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        expect_raises(Exception, spec_case[:exception_message]) do
          SpecSubCommandOnly.run_proc_arguments(spec_case[:argv])
        end
      end
    end
  end
end

class SpecSubCommandWithDesc < Clim
  main_command
  desc "Main command description is not target for spec."
  run do |opts, args|
    raise "Main command is not target for spec."
  end

  sub do
    command "sub_command"
    desc "Sub command with desc."
    run do |opts, args|
    end
  end
end

describe "sub command with desc." do
  describe "returns sub command help." do
    [
      {
        argv: %w(sub_command --help),
      },
      {
        argv: %w(sub_command --help ignore-arg),
      },
      {
        argv: %w(sub_command ignore-arg --help),
      },
      {
        argv: %w(sub_command --help -ignore-option),
      },
      {
        argv: %w(sub_command -ignore-option --help),
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        run_proc_opts, run_proc_args = SpecSubCommandWithDesc.run_proc_arguments(spec_case[:argv])
        run_proc_opts["help"].should eq(
          <<-HELP_MESSAGE

            Sub command with desc.

            Usage:

              sub_command [options] [arguments]

            Options:

              --help                           Show this help.


          HELP_MESSAGE
        )
      end
    end
  end
end

class SpecSubCommandWithUsage < Clim
  main_command
  desc "Main command description is not target for spec."
  usage "Main command usage is not target for spec."
  run do |opts, args|
    raise "Main command is not target for spec."
  end

  sub do
    command "sub_command"
    desc "Sub command with desc."
    usage "sub_command with usage [options] [arguments]"
    run do |opts, args|
    end
  end
end

describe "sub command with usage." do
  describe "returns sub command help." do
    [
      {
        argv: %w(sub_command --help),
      },
      {
        argv: %w(sub_command --help ignore-arg),
      },
      {
        argv: %w(sub_command ignore-arg --help),
      },
      {
        argv: %w(sub_command --help -ignore-option),
      },
      {
        argv: %w(sub_command -ignore-option --help),
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        run_proc_opts, run_proc_args = SpecSubCommandWithUsage.run_proc_arguments(spec_case[:argv])
        run_proc_opts["help"].should eq(
          <<-HELP_MESSAGE

            Sub command with desc.

            Usage:

              sub_command with usage [options] [arguments]

            Options:

              --help                           Show this help.


          HELP_MESSAGE
        )
      end
    end
  end
end

class SpecSubSubCommand < Clim
  main_command
  desc "Main command description is not target for spec."
  usage "Main command usage is not target for spec."
  run do |opts, args|
    raise "Main command is not target for spec."
  end

  sub do
    command "sub_command"
    desc "Sub command with desc."
    usage "sub_command with usage [options] [arguments]"
    run do |opts, args|
      raise "Sub command is not target for spec."
    end

    sub do
      command "sub_sub_command"
      desc "Sub sub command with desc."
      usage "sub_sub_command with usage [options] [arguments]"
      run do |opts, args|
      end
    end
  end
end

describe "sub sub command." do
  describe "returns sub sub command help." do
    [
      {
        argv: %w(sub_command sub_sub_command --help),
      },
      {
        argv: %w(sub_command sub_sub_command --help ignore-arg),
      },
      {
        argv: %w(sub_command sub_sub_command ignore-arg --help),
      },
      {
        argv: %w(sub_command sub_sub_command --help -ignore-option),
      },
      {
        argv: %w(sub_command sub_sub_command -ignore-option --help),
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        run_proc_opts, run_proc_args = SpecSubSubCommand.run_proc_arguments(spec_case[:argv])
        run_proc_opts["help"].should eq(
          <<-HELP_MESSAGE

            Sub sub command with desc.

            Usage:

              sub_sub_command with usage [options] [arguments]

            Options:

              --help                           Show this help.


          HELP_MESSAGE
        )
      end
    end
  end
  describe "returns sub command help when there is no sub_sub_command next to sub_command." do
    [
      {
        argv: %w(sub_command --help sub_sub_command),
      },
      {
        argv: %w(sub_command --help ignore-arg sub_sub_command),
      },
      {
        argv: %w(sub_command ignore-arg --help sub_sub_command),
      },
      {
        argv: %w(sub_command --help -ignore-option sub_sub_command),
      },
      {
        argv: %w(sub_command -ignore-option --help sub_sub_command),
      },
      {
        argv: %w(sub_command ignore-arg sub_sub_command --help),
      },
      {
        argv: %w(sub_command -ignore-option sub_sub_command --help),
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        run_proc_opts, run_proc_args = SpecSubSubCommand.run_proc_arguments(spec_case[:argv])
        run_proc_opts["help"].should eq(
          <<-HELP_MESSAGE

            Sub command with desc.

            Usage:

              sub_command with usage [options] [arguments]

            Options:

              --help                           Show this help.

            Sub Commands:

              sub_sub_command   Sub sub command with desc.


          HELP_MESSAGE
        )
      end
    end
  end
  describe "returns opts and args when passing argv." do
    [
      {
        argv:        %w(sub_command sub_sub_command),
        expect_opts: create_values,
        expect_args: [] of String,
      },
      {
        argv:        %w(sub_command sub_sub_command arg1),
        expect_opts: create_values,
        expect_args: ["arg1"],
      },
      {
        argv:        %w(sub_command sub_sub_command arg1 arg2),
        expect_opts: create_values,
        expect_args: ["arg1", "arg2"],
      },
      {
        argv:        %w(sub_command sub_sub_command arg1 arg2 arg3),
        expect_opts: create_values,
        expect_args: ["arg1", "arg2", "arg3"],
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        run_proc_opts, run_proc_args = SpecSubSubCommand.run_proc_arguments(spec_case[:argv])
        run_proc_opts.delete("help")
        run_proc_opts.should eq(spec_case[:expect_opts])
        run_proc_args.should eq(spec_case[:expect_args])
      end
    end
  end
  describe "raises Exception when passing invalid argv to main command." do
    [
      {
        argv:              %w(sub_command sub_sub_command -m),
        exception_message: "Undefined option. \"-m\"",
      },
      {
        argv:              %w(sub_command sub_sub_command --missing-option),
        exception_message: "Undefined option. \"--missing-option\"",
      },
      {
        argv:              %w(sub_command sub_sub_command -m arg1),
        exception_message: "Undefined option. \"-m\"",
      },
      {
        argv:              %w(sub_command sub_sub_command arg1 -m),
        exception_message: "Undefined option. \"-m\"",
      },
      {
        argv:              %w(sub_command sub_sub_command -m -d),
        exception_message: "Undefined option. \"-m\"",
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        expect_raises(Exception, spec_case[:exception_message]) do
          SpecSubSubCommand.run_proc_arguments(spec_case[:argv])
        end
      end
    end
  end
end

class SpecSubCommandJumpOverSubSubCommand < Clim
  main_command
  desc "Main command with desc."
  usage "main_command with usage [options] [arguments]"
  run do |opts, args|
    raise "Main command is not target for spec."
  end

  sub do
    command "sub_command"
    desc "Sub command with desc."
    usage "sub_command with usage [options] [arguments]"
    run do |opts, args|
      raise "Sub command is not target for spec."
    end

    sub do
      command "sub_sub_command"
      desc "Sub sub command with desc."
      usage "sub_sub_command with usage [options] [arguments]"
      run do |opts, args|
        raise "Sub sub command is not target for spec."
      end
    end

    command "jump_over_sub_sub_command"
    desc "Sub command jump over sub sub command."
    usage "jump_over_sub_sub_command with usage [options] [arguments]"
    run do |opts, args|
    end
  end
end

describe "sub command jump over sub sub command." do
  describe "returns jump over sub sub command help." do
    [
      {
        argv: %w(jump_over_sub_sub_command --help),
      },
      {
        argv: %w(jump_over_sub_sub_command --help ignore-arg),
      },
      {
        argv: %w(jump_over_sub_sub_command ignore-arg --help),
      },
      {
        argv: %w(jump_over_sub_sub_command --help -ignore-option),
      },
      {
        argv: %w(jump_over_sub_sub_command -ignore-option --help),
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        run_proc_opts, run_proc_args = SpecSubCommandJumpOverSubSubCommand.run_proc_arguments(spec_case[:argv])
        run_proc_opts["help"].should eq(
          <<-HELP_MESSAGE

            Sub command jump over sub sub command.

            Usage:

              jump_over_sub_sub_command with usage [options] [arguments]

            Options:

              --help                           Show this help.


          HELP_MESSAGE
        )
      end
    end
  end
  describe "returns main command help." do
    [
      {
        argv: %w(--help),
      },
      {
        argv: %w(--help ignore-arg),
      },
      {
        argv: %w(ignore-arg --help),
      },
      {
        argv: %w(--help -ignore-option),
      },
      {
        argv: %w(-ignore-option --help),
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        run_proc_opts, run_proc_args = SpecSubCommandJumpOverSubSubCommand.run_proc_arguments(spec_case[:argv])
        run_proc_opts["help"].should eq(
          <<-HELP_MESSAGE

            Main command with desc.

            Usage:

              main_command with usage [options] [arguments]

            Options:

              --help                           Show this help.

            Sub Commands:

              sub_command                 Sub command with desc.
              jump_over_sub_sub_command   Sub command jump over sub sub command.


          HELP_MESSAGE
        )
      end
    end
  end
  describe "returns opts and args when passing argv." do
    [
      {
        argv:        %w(jump_over_sub_sub_command),
        expect_opts: create_values,
        expect_args: [] of String,
      },
      {
        argv:        %w(jump_over_sub_sub_command arg1),
        expect_opts: create_values,
        expect_args: ["arg1"],
      },
      {
        argv:        %w(jump_over_sub_sub_command arg1 arg2),
        expect_opts: create_values,
        expect_args: ["arg1", "arg2"],
      },
      {
        argv:        %w(jump_over_sub_sub_command arg1 arg2 arg3),
        expect_opts: create_values,
        expect_args: ["arg1", "arg2", "arg3"],
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        run_proc_opts, run_proc_args = SpecSubCommandJumpOverSubSubCommand.run_proc_arguments(spec_case[:argv])
        run_proc_opts.delete("help")
        run_proc_opts.should eq(spec_case[:expect_opts])
        run_proc_args.should eq(spec_case[:expect_args])
      end
    end
  end
  describe "raises Exception when passing invalid argv to main command." do
    [
      {
        argv:              %w(jump_over_sub_sub_command -m),
        exception_message: "Undefined option. \"-m\"",
      },
      {
        argv:              %w(jump_over_sub_sub_command --missing-option),
        exception_message: "Undefined option. \"--missing-option\"",
      },
      {
        argv:              %w(jump_over_sub_sub_command -m arg1),
        exception_message: "Undefined option. \"-m\"",
      },
      {
        argv:              %w(jump_over_sub_sub_command arg1 -m),
        exception_message: "Undefined option. \"-m\"",
      },
      {
        argv:              %w(jump_over_sub_sub_command -m -d),
        exception_message: "Undefined option. \"-m\"",
      },
    ].each do |spec_case|
      it "#{spec_case[:argv].join(" ")}" do
        expect_raises(Exception, spec_case[:exception_message]) do
          SpecSubCommandJumpOverSubSubCommand.run_proc_arguments(spec_case[:argv])
        end
      end
    end
  end
end
