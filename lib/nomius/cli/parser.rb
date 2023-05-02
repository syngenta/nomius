# frozen_string_literal: true

require_relative "parser/file_parser"
require_relative "parser/strings_parser"

module Nomius
  class CLI
    # ParserChooser
    class Parser
      PARSER_BY_INPUT_FILE_PRESENCE = {
        true => FileParser,
        false => StringsParser
      }.freeze

      def self.names(file_name: nil, strings: [])
        PARSER_BY_INPUT_FILE_PRESENCE
          .fetch(!file_name.nil?)
          .names(file_name: file_name, strings: strings)
      end
    end
  end
end
