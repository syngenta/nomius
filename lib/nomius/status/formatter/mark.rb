# frozen_string_literal: true

require_relative "../available"
require_relative "../unavailable"
require_relative "../unresolved"

module Nomius
  module Status
    module Formatter
      # Generate status mark for Status
      class Mark
        STATUS_MAPPER = {
          Status::Available => "✅",
          Status::Unavailable => "❌",
          Status::Unresolved => "❓"
        }.freeze

        def self.for(status)
          STATUS_MAPPER.fetch(status.class)
        end
      end
    end
  end
end
