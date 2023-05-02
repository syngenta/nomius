# frozen_string_literal: true

require "tty-progressbar"
require_relative "../status/formatter/mark"

module Nomius
  class Logger
    # Verbose logger
    class Verbose
      def start_batch_processing(count)
        @progress_bar = TTY::ProgressBar.new("[:bar] :current/:total ET::elapsed ETA::eta") do |config|
          config.total = count
          config.interval = 5
        end
      end

      def batch_record_processing(name)
        log_info("Processing #{name.name}...")
        result = yield
        log_info("")
        progress_bar.advance

        result
      end

      def log_detector_status
        status = yield
        log_info("#{status.detector.detector_short_name}  #{Status::Formatter::Mark.for(status)}")

        status
      end

      def log_info(message)
        progress_bar.log(message)
      end

      def log_error(message: "", details: "")
        warn message
        warn details
      end

      private

      attr_reader :progress_bar
    end
  end
end
