require 'spec_helper'

describe LiveResource::RSpec do
  it 'should have a version number' do
    LiveResource::Rspec::VERSION.should_not be_nil
  end
end
