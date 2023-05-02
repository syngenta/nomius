# frozen_string_literal: true

require_relative "checker"
require_relative "detector"
require_relative "name"
require_relative "logger/silent"
require_relative "status/formatter/mark"

module Nomius
  # BulkChecker
  class BulkChecker
    RESULT = Struct.new(:name, :results, keyword_init: true)

    attr_reader :names, :detectors, :logger

    def self.check(*args, **kwargs)
      new(*args, **kwargs).check
    end

    def initialize(names: [], detectors: Detector.all, logger: Logger::Silent.new)
      @names = names.compact.map { |name| Name.for(name) }
      @detectors = detectors
      @logger = logger
    end

    def check
      logger.start_batch_processing(names.count)

      names.map do |name|
        logger.batch_record_processing(name) do
          RESULT.new(
            name: name,
            results: Checker.check(name: name, detectors: detectors, logger: logger)
          )
        end
      end
    end
  end
end
