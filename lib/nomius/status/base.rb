# frozen_string_literal: true

module Nomius
  module Status
    # Status for available domains.
    class Base
      attr_reader :name, :detector, :exception

      def initialize(name:, detector:, exception: nil)
        @name = name
        @detector = detector
        @exception = exception
      end
    end
  end
end
