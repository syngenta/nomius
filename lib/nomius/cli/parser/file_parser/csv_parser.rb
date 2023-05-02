# frozen_string_literal: true

require "csv"
require_relative "../../../name"

module Nomius
  class CLI
    class Parser
      class FileParser
        # Parser for CSV files
        class CSVParser
          attr_reader :file_name

          def self.names(file_name:)
            new(file_name: file_name).names
          end

          def initialize(file_name:)
            @file_name = file_name
          end

          def names
            CSV.read(file_name, skip_blanks: true, liberal_parsing: true).map do |name, comment|
              Name.new(name: name, comment: comment)
            end
          end
        end
      end
    end
  end
end
