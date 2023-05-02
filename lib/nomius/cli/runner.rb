# frozen_string_literal: true

require_relative "parser"
require_relative "writer/console_writer"
require_relative "writer/csv_writer"
require_relative "../bulk_checker"
require_relative "../logger"

module Nomius
  class CLI
    # CLI Runner
    class Runner
      attr_reader :names, :silent, :input, :output

      def self.run(*args, **kwargs)
        new(*args, **kwargs).run
      end

      def initialize(names: [], silent: false, input: nil, output: nil)
        @names = names
        @silent = silent
        @input = input
        @output = output
      end

      def run
        logger = Logger.for(silent: silent)
        writers = [Writer::ConsoleWriter]
        writers << Writer::CSVWriter if output

        results = BulkChecker.check(
          names: Parser.names(file_name: input, strings: names),
          logger: logger
        )

        writers.each do |writer|
          writer.write!(results: results, file_name: output)
        end
      end
    end
  end
end
