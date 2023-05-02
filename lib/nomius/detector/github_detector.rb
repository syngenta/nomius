# frozen_string_literal: true

require_relative "base_url_detector"

module Nomius
  class Detector
    # Check name availability for https://github.com/
    class GithubDetector < BaseURLDetector
      BASE_URL = "https://github.com"

      def detector_name
        "GitHub.com"
      end

      def detector_short_name
        "GH"
      end

      private

      def uri
        "#{BASE_URL}/#{name.name}"
      end
    end
  end
end
