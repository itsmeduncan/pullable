require 'spec_helper'

describe Pullable do

  it 'should have a version number' do
    Pullable::VERSION.should_not be_nil
  end

  it 'calls process! with the correct arguments' do
    Pullable::Directory.expects(:process!).with('foo', 'bar')
    Pullable.process!('foo', 'bar')
  end

end
