# frozen_string_literal: true

require 'spec_helper'

require 'time'

RSpec.describe Concourse::SubClients::SkymarshalClient do
  describe 'create_token' do
    describe 'pre version 6.1' do
      it 'creates a new token' do
        concourse_url = Build::Data.random_concourse_url
        csrf_token = Build::Data.random_csrf_token
        username = Build::Data.random_username
        password = Build::Data.random_password

        client = described_class.new(
          {
            url: concourse_url,
            version: '4.0.0'
          }
        )

        expiry_date = Times.one_hour_from_now
        bearer_token =
          Build::Data.random_bearer_token_pre_version_6_1(csrf: csrf_token)
        token_response_body =
          Build::ApiResponse.token_pre_version_6_1(
            access_token: bearer_token, expiry: expiry_date.iso8601
          )

        allow(Excon)
          .to(receive(:post)
                .with(Concourse::Urls.sky_token_url(concourse_url),
                      headers: token_request_headers,
                      body: token_request_body_pre_version_6_1(
                        password, username
                      ))
                .and_return(response_double(200, token_response_body)))

        token = client.create_token(username:, password:)

        expect(token)
          .to(eq(Concourse::Models::Token.new(
                   access_token: bearer_token,
                   token_type: 'bearer',
                   expires_at: expiry_date.iso8601,
                   id_token: bearer_token
                 )))
      end

      it 'throws an exception if the underlying request is not successful' do
        concourse_url = Build::Data.random_concourse_url
        username = Build::Data.random_username
        password = Build::Data.random_password

        client = described_class.new(
          {
            url: concourse_url,
            version: '4.0.0'
          }
        )

        allow(Excon)
          .to(receive(:post)
                .with(Concourse::Urls.sky_token_url(concourse_url),
                      headers: token_request_headers,
                      body: token_request_body_pre_version_6_1(
                        password, username
                      ))
                .and_return(
                  response_double(
                    401, {
                      error: 'access_denied',
                      error_description: 'Invalid username or password'
                    }
                  )
                ))

        expect do
          client.create_token(
            username:,
            password:
          )
        end.to(raise_error(Concourse::Errors::ApiError))
      end
    end

    describe 'post version 6.1' do
      it 'creates a new token' do
        concourse_url = Build::Data.random_concourse_url
        username = Build::Data.random_username
        password = Build::Data.random_password

        client = described_class.new(
          {
            url: concourse_url,
            version: '6.1.0'
          }
        )

        response_date = Time.now
        expiry_date = Times.one_hour_from(response_date)

        bearer_token = Build::Data.random_bearer_token_current
        id_token = Build::Data.random_id_token_current

        token_response_body =
          Build::ApiResponse.token_current(
            access_token: bearer_token,
            id_token:,
            expires_in: Times.one_hour_in_seconds
          )

        allow(Excon)
          .to(receive(:post)
                .with(Concourse::Urls.sky_issuer_token_url(concourse_url),
                      headers: token_request_headers,
                      body: token_request_body_current(password, username))
                .and_return(
                  response_double(200, token_response_body, {
                                    'Date' => response_date.httpdate
                                  })
                ))

        token = client.create_token(username:, password:)

        expect(token)
          .to(eq(Concourse::Models::Token.new(
                   access_token: bearer_token,
                   token_type: 'bearer',
                   expires_at: expiry_date.utc.localtime('+00:00').iso8601,
                   id_token:
                 )))
      end

      it 'throws an exception if the underlying request is not successful' do
        concourse_url = Build::Data.random_concourse_url
        username = Build::Data.random_username
        password = Build::Data.random_password

        client = described_class.new(
          {
            url: concourse_url,
            version: '6.1.0'
          }
        )

        allow(Excon)
          .to(receive(:post)
                .with(Concourse::Urls.sky_issuer_token_url(concourse_url),
                      headers: token_request_headers,
                      body: token_request_body_current(password, username))
                .and_return(
                  response_double(
                    401, {
                      error: 'access_denied',
                      error_description: 'Invalid username or password'
                    }
                  )
                ))

        expect do
          client.create_token(
            username:,
            password:
          )
        end.to(raise_error(Concourse::Errors::ApiError))
      end
    end
  end
end

def token_request_headers
  {}
    .merge(Concourse::Headers.content_type(
             Concourse::ContentTypes::APPLICATION_WWW_FORM_URLENCODED
           ))
    .merge(Concourse::Headers.authorization(
             Concourse::Authorization.basic(
               'fly', 'Zmx5'
             )
           ))
end

# rubocop:disable Naming/VariableNumber
def token_request_body_pre_version_6_1(password, username)
  URI.encode_www_form(
    {
      grant_type: 'password',
      username:,
      password:,
      scope: 'openid+profile+email+federated:id+groups'
    }
  )
end
# rubocop:enable Naming/VariableNumber

def token_request_body_current(password, username)
  URI.encode_www_form(
    {
      grant_type: 'password',
      username:,
      password:,
      scope: 'openid profile email federated:id groups'
    }
  )
end

def response_double(status, body, headers = {})
  instance_double(
    Excon::Response,
    status:,
    headers:,
    body: JSON.dump(body)
  )
end
