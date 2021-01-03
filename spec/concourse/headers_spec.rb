require 'spec_helper'

describe 'headers' do
  context 'authorization' do
    it 'creates a basic authorization header value' do
      expect(
          Concourse::Authorization.basic(
              'fly', 'Zmx5'))
          .to(eq('Basic Zmx5OlpteDU='))
    end

    it 'creates a bearer authorization header value' do
      bearer_token = Build::Data.random_bearer_token_current

      expect(
          Concourse::Authorization.bearer(bearer_token))
          .to(eq("Bearer #{bearer_token}"))
    end
  end
end
