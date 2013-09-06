require 'spec_helper'

describe Pullable::Directory do

  describe '.new' do
    it 'raises if the directory does not exist' do
      File.expects(:directory?).with('foo').returns(false)

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
      Pullable::Directory.expects(:new).with('foo', 'bar').returns(mock(:process! => true))
      Pullable::Directory.process!('foo', 'bar')
    end

    it 'defaults the method to merge' do
      Pullable::Directory.expects(:new).with('foo', 'merge').returns(mock(:process! => true))
      Pullable::Directory.process!('foo')
    end
  end

  describe '.process!' do
    it 'calls update for each directory that has a .git under the root'
    it 'skips known weird directories'
    it 'skips non-git repos'
  end

  describe '#update!' do
    it 'calls the correct system command' do
      directory = described_class.new('.', 'merge')
      directory.expects(:system).with('git fetch -p && git merge --ff-only origin/master > /dev/null')

      directory.update!
    end
  end

  describe "#command" do
    it 'generates the merge command' do
      directory = described_class.new('.', 'merge')
      directory.command.should == 'git merge --ff-only origin/master'
    end

    it 'generates the pull command' do
      directory = described_class.new('.', 'pull')
      directory.command.should == 'git pull origin master'
    end
  end

end