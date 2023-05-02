# frozen_string_literal: true

require "uri"
require_relative "base_domain_name_detector"

module Nomius
  class Detector
    # Check .org domain name availability
    class DomainOrgDetector < BaseDomainNameDetector
      def tld
        ".org"
      end
    end
  end
end
