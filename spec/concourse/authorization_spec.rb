# frozen_string_literal: true

require 'spec_helper'

describe Concourse::Authorization do
  it 'creates a basic authorization header value' do
    expect(described_class.basic('fly', 'Zmx5'))
      .to(eq('Basic Zmx5OlpteDU='))
  end

  it 'creates a bearer authorization header value' do
    bearer_token = Build::Data.random_bearer_token_current

    expect(described_class.bearer(bearer_token))
      .to(eq("Bearer #{bearer_token}"))
  end
end
