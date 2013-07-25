require 'spec_helper'

describe Pullable do

  it 'should have a version number' do
    Pullable::VERSION.should_not be_nil
  end

end
