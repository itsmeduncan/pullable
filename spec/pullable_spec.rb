require 'spec_helper'

describe Pullable do

  it 'should have a version number' do
    Pullable::VERSION.should_not be_nil
  end

  it 'calls process! with the correct arguments' do
    Pullable::Directory.expects(:process!).with('foo', 'bar')
    Pullable.process!('foo', 'bar')
  end

  it 'handles a blank string for the method' do
    Pullable::Directory.expects(:process!).with('foo', 'merge')
    Pullable.process!('foo', '')
  end

  it 'handles a nil method' do
    Pullable::Directory.expects(:process!).with('foo', 'merge')
    Pullable.process!('foo')
  end

end
