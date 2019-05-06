require 'spec_helper'

describe Pullable::Directory do

  describe '.new' do
    it 'raises if the directory does not exist' do
      expect(File).to receive(:directory?).with('foo').and_return(false)

      expect {
        described_class.new('foo', 'merge')
      }.to raise_error(ArgumentError, 'Please pass a directory that exists!')
    end

    it 'raises if the method is invalid' do
      expect {
        described_class.new('.', 'foo')
      }.to raise_error(ArgumentError, 'foo cannot be used to update the repo!')
    end
  end

  describe '#process!' do
    it 'initializes a new Pullable::Directory with the given parameters' do
      expect(Pullable::Directory).to receive(:new).with('foo', 'bar').and_return(double(:process! => true))
      Pullable::Directory.process!('foo', 'bar')
    end

    it 'defaults the method to merge' do
      expect(Pullable::Directory).to receive(:new).with('foo', 'merge').and_return(double(:process! => true))
      Pullable::Directory.process!('foo')
    end
  end

  describe '.process!' do
    it 'calls update for each directory that has a .git under the root'
    it 'skips known weird directories'
    it 'skips non-git repos'
  end

  describe '#update!' do
    it 'calls the correct system command'
  end

end
