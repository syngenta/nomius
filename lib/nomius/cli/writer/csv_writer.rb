# frozen_string_literal: true

require "csv"
require_relative "../../status/formatter/ascii_mark"

module Nomius
  class CLI
    class Writer
      # CSVWriter
      class CSVWriter
        attr_reader :results, :file_name

        def self.write!(*args, **kwargs)
          new(*args, **kwargs).write!
        end

        def initialize(file_name:, results: [], **_kwargs)
          @results = results
          @file_name = file_name
        end

        def write!
          CSV.open(file_name, "w") do |f|
            f << headers
            rows.each { |row| f << row }
          end
        end

        private

        def headers
          [
            "Name",
            "Comment",
            *results.first.results.map(&:detector).map(&:detector_name)
          ]
        end

        def rows
          results.map do |result|
            [
              result.name.name,
              result.name.comment,
              *result.results.map { |status| Status::Formatter::ASCIIMark.for(status) }
            ]
          end
        end
      end
    end
  end
end
