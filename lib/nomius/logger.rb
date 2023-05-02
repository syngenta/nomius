# frozen_string_literal: true

require_relative "logger/silent"
require_relative "logger/verbose"

module Nomius
  # Logger factory
  class Logger
    LOGGER_BY_SILENT = {
      true => Silent,
      false => Verbose
    }.freeze

    def self.for(silent: false)
      LOGGER_BY_SILENT.fetch(silent).new
    end
  end
end
