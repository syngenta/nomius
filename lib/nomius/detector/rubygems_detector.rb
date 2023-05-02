# frozen_string_literal: true

require_relative "base_url_detector"

module Nomius
  class Detector
    # Check name availability for https://rubygems.org/
    class RubygemsDetector < BaseURLDetector
      BASE_URL = "https://rubygems.org/api/v1/gems"

      def detector_name
        "RubyGems.org"
      end

      def detector_short_name
        "gem"
      end

      private

      def uri
        "#{BASE_URL}/#{name.name}"
      end
    end
  end
end
