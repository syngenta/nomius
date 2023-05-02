# frozen_string_literal: true

require_relative "base_url_detector"

module Nomius
  class Detector
    # Check name availability for https://hub.docker.com/
    class DockerhubDetector < BaseURLDetector
      BASE_URL = "https://hub.docker.com/v2/orgs"

      def detector_name
        "hub.docker.com"
      end

      def detector_short_name
        "Docker"
      end

      private

      def uri
        "#{BASE_URL}/#{name.name}"
      end
    end
  end
end
