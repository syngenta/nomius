# frozen_string_literal: true

require_relative "base_url_detector"

module Nomius
  class Detector
    # Check name availability for https://pypi.org/
    class PypiDetector < BaseURLDetector
      BASE_URL = "https://pypi.org/project"

      def detector_name
        "PyPi.org"
      end

      def detector_short_name
        "pip"
      end

      private

      def uri
        "#{BASE_URL}/#{name.name}"
      end
    end
  end
end
