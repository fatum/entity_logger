module EntityLogger
  class << self
    attr_accessor :logger
  end

  def self.configure(&block)
    yield(self)
  end

  def self.tagged_logger
    self.logger ||= ActiveSupport::BufferedLogger.new(StringIO.new)

    @@tagged_logger ||= ActiveSupport::TaggedLogging.new(self.logger)
  end
end
