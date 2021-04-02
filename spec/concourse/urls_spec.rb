# frozen_string_literal: true

require 'spec_helper'

describe Concourse::Urls do
  it 'returns info URL' do
    concourse_url = 'https://concourse.example.com/'

    expect(described_class.info_url(concourse_url))
      .to(eq('https://concourse.example.com/api/v1/info'))
  end

  it 'returns sky token URL' do
    concourse_url = 'https://concourse.example.com/'

    expect(described_class.sky_token_url(concourse_url))
      .to(eq('https://concourse.example.com/sky/token'))
  end

  it 'returns sky issuer token URL' do
    concourse_url = 'https://concourse.example.com/'

    expect(described_class.sky_issuer_token_url(concourse_url))
      .to(eq('https://concourse.example.com/sky/issuer/token'))
  end
end
