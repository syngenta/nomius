# frozen_string_literal: true

require_relative "../../name"

module Nomius
  class CLI
    class Parser
      # Parser for array of strings
      class StringsParser
        def self.names(strings:, **_kwargs)
          new(strings: strings).names
        end

        def initialize(strings:, **_kwargs)
          @strings = strings
        end

        def names
          cleared_names.map do |name|
            Name.new(name: name)
          end
        end

        private

        attr_reader :strings

        def cleared_names
          strings
            .reject { |name| name.strip.empty? }
            .sort
            .uniq
        end
      end
    end
  end
end
