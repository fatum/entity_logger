require 'spec_helper'

describe EntityLogger do
  class EntityClass2
    include EntityLogger::Mixin

    log Logger.new(STDOUT), 'Prefix', :attr22
  end

  class EntityClass
    include EntityLogger::Mixin

    log Logger.new(STDOUT), 'Prefix', :attr1 => lambda { |e| 'T' }, :attr2 => lambda { |e| 'D' }, :attr3 => lambda { |e| e.attr1 + e.attr2 }

    def attr1
      'test1'
    end

    def attr2
      'test2'
    end
  end

  %w(info debug error).each do |level|
    it "should receive logger method: #{level}" do
      obj = EntityClass.new
      EntityLogger::TaggedLogging.any_instance.should_receive(level.to_sym).with('Test', ["T", "D", "test1test2"])
      obj.send(level, 'Test')
    end
  end
end
