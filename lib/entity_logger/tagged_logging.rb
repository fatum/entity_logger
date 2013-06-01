require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/logger'
require 'active_support/deprecation'

module EntityLogger
  class TaggedLogging
    def initialize(logger, prefix)
      @logger, @prefix = logger, prefix
    end

    [:debug, :info, :error, :fatal].each do |_m|
      define_method(_m) do |message, tags|
        text = "#{@prefix} #{tags_text(tags)}#{message}"

        @logger.send(_m, text)
      end
    end

    private

    def tags_text(tags)
      if tags.any?
        tags.collect { |tag| "[#{tag}] " }.join
      end
    end
  end
end
