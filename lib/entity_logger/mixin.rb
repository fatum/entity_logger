require 'active_support/concern'
require 'active_support/core_ext'
require 'active_support/tagged_logging'

module EntityLogger
  module Mixin
    extend ActiveSupport::Concern

    included do
      cattr_accessor :tags_for_logging

      def self.log(*attrs)
        self.tags_for_logging ||= attrs
      end
    end

    %w(info error debug).each do |level|
      define_method(level) do |msg|
        tags = extract_tags(self.tags_for_logging)

        logger = EntityLogger.tagged_logger
        logger.tagged(tags) { logger.send(level, msg) }
      end
    end

  private
    def extract_tags(attrs)
      attrs.map do |attr|
        case attr
        when Hash
          attr.values.first.call(self)
        else
          send(attr)
        end
      end
    end
  end
end
