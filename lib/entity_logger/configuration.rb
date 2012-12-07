require 'entity_logger/tagged_logging'

module EntityLogger
  class << self
    attr_accessor :logger, :tagged_logger
  end

  def self.configure(&block)
    yield(self)
  end

  def self.tagged_logger
    self.logger ||= ActiveSupport::BufferedLogger.new(STDOUT)
    @@tagged_logger ||= EntityLogger::TaggedLogging.new(self.logger)
  end
end
