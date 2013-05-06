# LiveResource::Rspec

Adds custom matchers and helper methods for testing LiveResource with RSpec.

## Installation

Add this line to your application's Gemfile:

    gem 'live_resource-rspec'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install live_resource-rspec

## Usage

```ruby
# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  live_resource :profile_show do
    identifier { |profile| profile_path(profile) }
    depends_on(Profile) { |profile| push(profile) } # Requires live_resource-activerecord
    depends_on(Avatar) { |avatar| push(avatar.profile) }
  end
end
```

```ruby
# spec/controllers/profiles_controller_spec.rb
require "spec_helper"

describe ProfilesController do

  describe "profile_show_resource" do
    subject { resource }

    let(:resource) { controller.profile_show_resource }

    expect_it { to depend_on(Profile) }
    expect_it { to depend_on(Avatar) }

    describe '#identifier' do
      subject { controller.profile_show_resource.identifier(profile) }

      let(:profile) { double(Profile) }

      it { should == profile_path(profile) }
    end

    describe 'the Profile dependency' do
      subject { dependency.invoke(profile) }

      let(:dependency) { dependency_on(resource, Profile) }
      let(:profile) { double(Profile) }

      it 'should push an update to the profile' do
        resource.should_receive(:push).with(profile)
        subject
      end
    end

    ...
  end

end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
