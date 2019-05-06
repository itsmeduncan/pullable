require 'spec_helper'

describe Pullable do

  it 'should have a version number' do
    expect(Pullable::VERSION).not_to be_nil
  end

  it 'calls process! with the correct arguments' do
    expect(Pullable::Directory).to receive(:process!).with('foo', 'bar')
    Pullable.process!('foo', 'bar')
  end

  it 'handles a blank string for the method' do
    expect(Pullable::Directory).to receive(:process!).with('foo', 'merge')
    Pullable.process!('foo', '')
  end

  it 'handles a nil method' do
    expect(Pullable::Directory).to receive(:process!).with('foo', 'merge')
    Pullable.process!('foo')
  end

end
