# frozen_string_literal: true

require_relative "../../../name"

module Nomius
  class CLI
    class Parser
      class FileParser
        # Parser for TXT files
        class TXTParser
          attr_reader :file_name

          def self.names(file_name:)
            new(file_name: file_name).names
          end

          def initialize(file_name:)
            @file_name = file_name
          end

          def names
            cleared_names.map do |name|
              Name.new(name: name)
            end
          end

          private

          def cleared_names
            File
              .readlines(file_name)
              .reject { |name| name.strip.empty? }
              .sort
              .uniq
          end
        end
      end
    end
  end
end
