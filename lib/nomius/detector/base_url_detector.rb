# frozen_string_literal: true

require_relative "../status"
require_relative "util/http_requester"
module Nomius
  class Detector
    # Base class for detectors.
    class BaseURLDetector
      STATUS_RESOLVER = {
        Util::HTTPRequester::NotFound => Status::Available,
        Util::HTTPRequester::OK => Status::Unavailable,
        Util::HTTPRequester::Unresolved => Status::Unresolved
      }.freeze

      attr_reader :name, :logger

      def self.status(*args, **kwargs)
        new(*args, **kwargs).status
      end

      def initialize(name:, logger: Logger::Silent, http_requester: Util::HTTPRequester)
        @name = name
        @logger = logger
        @http_requester = http_requester
      end

      def detector_name
        "Undefined"
      end

      def detector_short_name
        "Undefined"
      end

      def status
        STATUS_RESOLVER
          .fetch(http_requester.response_status(uri: uri, logger: logger))
          .new(name: name, detector: self)
      end

      private

      attr_reader :http_requester
    end
  end
end
