# frozen_string_literal: true

module Nomius
  # Name object
  class Name
    attr_reader :name, :comment

    def self.for(name)
      return name if name.is_a?(self)

      new(name: name.to_s)
    end

    def initialize(name:, comment: "")
      @name = name.to_s.strip.downcase
      @comment = comment.to_s.strip.downcase
      validate!
    end

    private

    def validate!
      raise ArgumentError, "Name cannot be blank" if name.empty?
    end
  end
end
