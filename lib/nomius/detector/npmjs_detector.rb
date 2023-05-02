# frozen_string_literal: true

require_relative "base_url_detector"

module Nomius
  class Detector
    # Check name availability for https://www.npmjs.com/
    class NpmjsDetector < BaseURLDetector
      BASE_URL = "https://registry.npmjs.org"

      def detector_name
        "NPMjs.com"
      end

      def detector_short_name
        "npm"
      end

      private

      def uri
        "#{BASE_URL}/#{name.name}"
      end
    end
  end
end
