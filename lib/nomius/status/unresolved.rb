# frozen_string_literal: true

require_relative "base"

module Nomius
  module Status
    # Status for name availability unresolved. Should be checked manually.
    class Unresolved < Base
      def available?
        false
      end

      def unavailalbe?
        false
      end

      def unresolved?
        true
      end
    end
  end
end
