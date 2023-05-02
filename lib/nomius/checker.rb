# frozen_string_literal: true

require_relative "detector"
require_relative "name"
require_relative "logger/silent"

module Nomius
  # Checker
  class Checker
    attr_reader :name, :detectors, :logger

    def self.check(*args, **kwargs)
      new(*args, **kwargs).check
    end

    def initialize(name:, detectors: Detector.all, logger: Logger::Silent.new)
      @name = Name.for(name)
      @detectors = detectors
      @logger = logger
    end

    def check
      detectors.map do |detector|
        logger.log_detector_status do
          detector.status(name: name, logger: logger)
        end
      end
    end
  end
end
