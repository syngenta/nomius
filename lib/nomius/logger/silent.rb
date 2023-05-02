# frozen_string_literal: true

module Nomius
  class Logger
    # Silent logger
    class Silent
      def start_batch_processing(_count)
        # Intentionally do nothing
      end

      def batch_record_processing(_name)
        # Intentionally do nothing
        yield
      end

      def log_detector_status
        # Intentionally do nothing
        yield
      end

      def log_info(_message)
        # Intentionally do nothing
      end

      def log_error(message: "", details: "")
        warn message
        warn details
      end
    end
  end
end
