require 'spec_helper'

describe Pullable do

  xit 'should have a version number' do
    Pullable::VERSION.should_not be_nil
  end

  xit 'calls process! with the correct arguments' do
    Pullable::Directory.expects(:process!).with('foo', 'bar')
    Pullable.process!('foo', 'bar')
  end

  xit 'handles a blank string for the method' do
    Pullable::Directory.expects(:process!).with('foo', 'merge')
    Pullable.process!('foo', '')
  end

  xit 'handles a nil method' do
    Pullable::Directory.expects(:process!).with('foo', 'merge')
    Pullable.process!('foo')
  end

end
