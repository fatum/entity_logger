require 'active_support/concern'
require 'active_support/core_ext/class'
require 'active_support/core_ext/object/blank'
require 'active_support/deprecation'
require 'logger'

module EntityLogger
  module Mixin
    extend ActiveSupport::Concern

    included do
      cattr_accessor :tags_for_logging
      self.tags_for_logging = []

      def self.log(*attrs)
        self.tags_for_logging = attrs
      end
    end

    def log_with_tags(&block)
      tags = extract_tags(self.tags_for_logging)
      logger.tagged(tags) { yield } if tags
    end

    def logger
      EntityLogger.tagged_logger
    end

    %w(info error debug).each do |level|
      define_method(level) do |msg|
        tags = extract_tags(self.tags_for_logging)

        if tags
          logger.tagged(tags) { logger.send(level, msg) }
        else
          logger.send(level, msg)
        end
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
