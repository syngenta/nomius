# frozen_string_literal: true

require "tty-option"
require_relative "../version"

module Nomius
  class CLI
    # Console options parser
    class Command
      include TTY::Option

      usage do
        program "nomius"
        no_command
        desc "Nomius — bulk domain & package name availability checker."
        example <<~DESCRIPTION
          Basic usage
          Check "firstname" and "othername" names.
            $ nomius firstname othername

          Usage with a TXT file
            $ nomius --input names.txt
          or
            $ cat names.txt | nomius
          or
            $ nomius < names.txt

          Usage with a CSV file
            $ nomius --input names.csv

          Usage with a CSV file and output to a CSV file
            $ nomius --input names.csv --output results.csv
        DESCRIPTION
      end

      flag :help do
        short "-h"
        long "--help"
        desc "Print usage"
      end

      flag :silent do
        short "-s"
        long "--silent"
        desc "Print less output"
      end

      flag :version do
        long "--version"
        desc "Print version"
      end

      option :input do
        short "-i"
        long "--input string"
        desc <<~DESCRIPTION
          Input file. Could be:
          - TXT with each name on a separate line;
          - CSV file with 2 columns: "name","comment" ("comment" is optional).
        DESCRIPTION
      end

      option :output do
        short "-o"
        long "--output string"
        desc "Output CSV file"
      end

      argument :names do
        arity zero_or_more
        # Read from STDIN to support piping.
        default -> { $stdin.tty? ? [] : $stdin.each_line.to_a }
        convert :list
      end

      def run
        check_help!
        check_version!
        check_input!
      end

      private

      def check_help!
        return unless params[:help]

        print help
        exit
      end

      def check_version!
        return unless params[:version]

        puts Nomius::VERSION
        exit
      end

      def check_input!
        return unless params[:names].empty? && params[:input].nil?

        print help
        exit(1)
      end
    end
  end
end
