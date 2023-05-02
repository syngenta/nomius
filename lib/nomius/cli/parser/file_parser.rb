# frozen_string_literal: true

require_relative "../../name"
require_relative "file_parser/txt_parser"
require_relative "file_parser/csv_parser"

module Nomius
  class CLI
    class Parser
      # Parser for files
      class FileParser
        FALLBACK_PARSER = TXTParser

        PARSER_BY_FILE_EXTENSION = {
          ".csv" => CSVParser
        }.freeze

        def self.names(file_name:, **_kwargs)
          PARSER_BY_FILE_EXTENSION
            .fetch(File.extname(file_name), FALLBACK_PARSER)
            .new(file_name: file_name)
            .names
        end
      end
    end
  end
end
