# frozen_string_literal: true

require_relative "detector/dockerhub_detector"
require_relative "detector/domain_com_detector"
require_relative "detector/domain_org_detector"
require_relative "detector/github_detector"
require_relative "detector/npmjs_detector"
require_relative "detector/pypi_detector"
require_relative "detector/rubygems_detector"

module Nomius
  # Detectors
  class Detector
    DETECTORS = [
      DomainComDetector,
      DomainOrgDetector,
      GithubDetector,
      DockerhubDetector,
      NpmjsDetector,
      PypiDetector,
      RubygemsDetector
    ].freeze

    def self.all
      DETECTORS
    end
  end
end
