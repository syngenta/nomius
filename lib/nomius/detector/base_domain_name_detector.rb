# frozen_string_literal: true

require "resolv"
require "retriable"
require "whois"
require "whois-parser"
require_relative "../status"

module Nomius
  class Detector
    # Detects domain is taken.
    # Works in 2 steps:
    # 1. Resolve DNS A record.
    # 2. If there is no A record, check WHOIS record.
    class BaseDomainNameDetector
      # NOTE: OpenDNS servers (https://www.opendns.com/)
      NANE_SERVERS = ["208.67.222.222", "208.67.220.220"].freeze

      STATUS_RESOLVER = {
        true => Status::Available,
        false => Status::Unavailable
      }.freeze

      attr_reader :name, :logger

      def self.status(*args, **kwargs)
        new(*args, **kwargs).status
      end

      def initialize(name:, logger: Logger::Silent)
        @name = name
        @logger = logger
      end

      def tld
        ".org"
      end

      def detector_name
        "#{name.name}#{tld}"
      end

      def detector_short_name
        tld
      end

      def status
        status_class.new(name: name, detector: self)
      end

      private

      def status_class
        STATUS_RESOLVER.fetch(availabile_by_dns? && availabile_by_whois?)
      rescue Whois::ConnectionError, Whois::ParserError, Timeout::Error => e
        logger.log_error(message: "Can't resolve: #{full_domain_name}", detalis: e.message)
        Status::Unresolved
      end

      def full_domain_name
        "#{name.name}#{tld}"
      end

      def availabile_by_dns?
        Resolv::DNS
          .new(nameserver: NANE_SERVERS)
          .getresources(Resolv::DNS::Name.create(full_domain_name), Resolv::DNS::Resource::IN::SOA)
          .empty?
      end

      def availabile_by_whois?
        Retriable.retriable(
          on: [Whois::ConnectionError, Timeout::Error],
          tries: 6, multiplier: 2, base_interval: 1
        ) do
          Whois.whois(full_domain_name).parser.available?
        end
      rescue Whois::ParserError => e
        # NOTE: Hotfix for whois-parser broken parser for .org.
        return true if e.message.include?("Domain not found")

        raise e
      end
    end
  end
end
