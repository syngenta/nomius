# frozen_string_literal: true

require "uri"
require_relative "base_domain_name_detector"

module Nomius
  class Detector
    # Check .com domain name availability
    class DomainComDetector < BaseDomainNameDetector
      def tld
        ".com"
      end
    end
  end
end
