require 'spec_helper'

describe EntityLogger do
  class EntityClass2
    include EntityLogger::Mixin

    log :attr22
  end

  class EntityClass
    include EntityLogger::Mixin

    log :attr1, :attr1, :attr3 => lambda { |e| e.attr1 + e.attr2 }

    def attr1
      'test1'
    end

    def attr2
      'test2'
    end
  end

  describe "#log_with_tags" do
    it 'should wrap inner log call with tags' do
      obj = EntityClass.new
      obj.log_with_tags { obj.logger.info('test') }.should be_true
    end
  end

  %w(info debug error).each do |level|
    it "should receive logger method: #{level}" do
      obj = EntityClass.new
      EntityLogger::TaggedLogging.any_instance.should_receive(level.to_sym).with('Test')
      obj.send(level, 'Test')
    end
  end
end
