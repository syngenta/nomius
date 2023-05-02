# frozen_string_literal: true

require_relative "cli/command"
require_relative "cli/runner"

module Nomius
  # CLI
  class CLI
    attr_reader :names, :silent, :input, :output

    def self.run(args = ARGV)
      cmd = Command.new.parse(args)
      cmd.run
      params = cmd.params

      Runner.run(
        names: params[:names],
        silent: params[:silent],
        input: params[:input],
        output: params[:output]
      )
    end
  end
end
