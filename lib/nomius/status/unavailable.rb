# frozen_string_literal: true

require_relative "base"

module Nomius
  module Status
    # Status for name unavailable.
    class Unavailable < Base
      def available?
        false
      end

      def unavailalbe?
        true
      end

      def unresolved?
        false
      end
    end
  end
end
