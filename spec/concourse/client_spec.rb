require 'spec_helper'

RSpec.describe Concourse::Client do
  it 'has a version number' do
    expect(Concourse::Client.new).not_to be nil
  end
end
