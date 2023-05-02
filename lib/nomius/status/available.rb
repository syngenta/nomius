# frozen_string_literal: true

require_relative "base"

module Nomius
  module Status
    # Status for name available.
    class Available < Base
      def available?
        true
      end

      def unavailalbe?
        false
      end

      def unresolved?
        false
      end
    end
  end
end
