# frozen_string_literal: true

require "faraday"
require "faraday/retry"
require "faraday/follow_redirects"

require_relative "../../version"

module Nomius
  class Detector
    class Util
      # Encapsulates HTTP request handling.
      # Using Faraday gem. But could be easily replaced with any other HTTP client.
      class HTTPRequester
        # rubocop:disable Lint/EmptyClass
        class OK; end
        class NotFound; end
        class Unresolved; end
        # rubocop:enable Lint/EmptyClass

        HEADERS = {
          "User-Agent" => "Nomius/#{Nomius::VERSION}"
        }.freeze

        FALLBACK_STATUS = Unresolved

        RESPONSE_STATUS_RESOLVER = {
          200 => OK,
          404 => NotFound
        }.freeze

        RETRY_STATUSES = [
          400, 401, 403, 408, 409, 418, 425, 429,
          500, 502, 503, 504
        ].freeze

        RETRY_OPTIONS = {
          max: 5,
          interval: 1,
          interval_randomness: 0.5,
          backoff_factor: 2,
          retry_statuses: RETRY_STATUSES
        }.freeze

        attr_reader :uri, :logger

        def self.response_status(uri:, logger:)
          new(uri: uri, logger: logger).response_status
        end

        def initialize(uri:, logger:)
          @uri = uri.to_s
          @logger = logger
        end

        def response_status
          # HEAD request is used to avoid downloading the whole page.
          response = connection.head

          unless RESPONSE_STATUS_RESOLVER.key?(response.status)
            logger.log_error(message: uri, details: response.to_hash.to_json)
          end

          RESPONSE_STATUS_RESOLVER.fetch(response.status, FALLBACK_STATUS)
        end

        private

        def connection
          @connection ||= Faraday.new(url: uri, headers: HEADERS) do |faraday|
            faraday.request :retry, RETRY_OPTIONS
            faraday.response :follow_redirects
          end
        end
      end
    end
  end
end
