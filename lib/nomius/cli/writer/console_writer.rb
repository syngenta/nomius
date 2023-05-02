# frozen_string_literal: true

require "tty-table"
require_relative "../../status/formatter/mark"

module Nomius
  class CLI
    class Writer
      # ConsoleWriter
      class ConsoleWriter
        attr_reader :results

        TTY_TABLE_WIDTH = {
          "fixed" => 80,
          "flexible" => nil
        }.freeze

        TTY_TABLE_OPTIONS = {
          padding: [0, 1],
          multiline: true,
          width: TTY_TABLE_WIDTH.fetch(ENV.fetch("TTY_TABLE_WIDTH", "flexible"))
        }.compact.freeze

        def self.write!(*args, **kwargs)
          new(*args, **kwargs).write!
        end

        def initialize(results: [], **_kwargs)
          @results = results
        end

        def write!
          table = TTY::Table.new(headers, rows)
          renderer = TTY::Table::Renderer::Unicode.new(table, TTY_TABLE_OPTIONS)

          puts renderer.render
        end

        private

        def headers
          [
            "Name",
            *results.first.results.map(&:detector).map(&:detector_short_name),
            "Comment"
          ]
        end

        def rows
          results.map do |result|
            [
              result.name.name,
              *result.results.map { |status| status_mark_cell(status) },
              result.name.comment
            ]
          end
        end

        def status_mark_cell(status)
          {
            value: Status::Formatter::Mark.for(status),
            alignment: :center
          }
        end
      end
    end
  end
end
