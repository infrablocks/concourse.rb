require 'spec_helper'

RSpec.describe Concourse::SubClients::SkymarshalClient do
  context 'create_token' do
    context 'pre version 6.1' do
      it 'creates a new token' do
        concourse_url = Build::Data.random_concourse_url
        csrf_token = Build::Data.random_csrf_token
        username = Build::Data.random_username
        password = Build::Data.random_password

        client = Concourse::SubClients::SkymarshalClient.new({
            url: concourse_url,
            version: '4.0.0',
        })

        one_hour_in_days = 1/24.0
        expiry_date_time = DateTime.now + one_hour_in_days
        bearer_token =
            Build::Data.random_bearer_token_pre_version_6_1(
                csrf: csrf_token)
        token_response_body =
            Build::ApiResponse.token_pre_version_6_1(
                access_token: bearer_token,
                expiry: expiry_date_time.iso8601)

        expected_request_headers = {}
            .merge(Concourse::Headers.content_type(
                Concourse::ContentTypes::APPLICATION_WWW_FORM_URLENCODED))
            .merge(Concourse::Headers.authorization(
                Concourse::Authorization.basic(
                    "fly", "Zmx5")))
        expected_request_body = URI.encode_www_form({
            grant_type: 'password',
            username: username,
            password: password,
            scope: 'openid+profile+email+federated:id+groups'
        })

        expect(Excon)
            .to(receive(:post)
                .with(Concourse::Urls.sky_token_url(concourse_url),
                    headers: expected_request_headers,
                    body: expected_request_body)
                .and_return(double('token response',
                    status: 200,
                    body: JSON.dump(token_response_body))))

        token = client.create_token(
            username: username,
            password: password)

        expect(token).to(eq(
            access_token: bearer_token,
            token_type: 'bearer',
            expires_at: expiry_date_time.iso8601,
            id_token: bearer_token))
      end
    end

    context 'post version 6.1' do
      it 'creates a new token' do
        concourse_url = Build::Data.random_concourse_url
        username = Build::Data.random_username
        password = Build::Data.random_password

        client = Concourse::SubClients::SkymarshalClient.new({
            url: concourse_url,
            version: '6.1.0',
        })

        one_hour_in_days = 1/24.0
        one_hour_in_seconds = 60 * 60

        response_date_time = DateTime.now
        expiry_date_time = response_date_time + one_hour_in_days

        bearer_token = Build::Data.random_bearer_token_current
        id_token = Build::Data.random_id_token_current

        token_response_body =
            Build::ApiResponse.token_current(
                access_token: bearer_token,
                id_token: id_token,
                expires_in: one_hour_in_seconds)

        expected_request_headers = {}
            .merge(Concourse::Headers.content_type(
                Concourse::ContentTypes::APPLICATION_WWW_FORM_URLENCODED))
            .merge(Concourse::Headers.authorization(
                Concourse::Authorization.basic(
                    "fly", "Zmx5")))
        expected_request_body = URI.encode_www_form({
            grant_type: 'password',
            username: username,
            password: password,
            scope: 'openid profile email federated:id groups'
        })

        expect(Excon)
            .to(receive(:post)
                .with(Concourse::Urls.sky_issuer_token_url(concourse_url),
                    headers: expected_request_headers,
                    body: expected_request_body)
                .and_return(double('token response',
                    status: 200,
                    headers: {
                        "Date" => expiry_date_time.httpdate
                    },
                    body: JSON.dump(token_response_body))))

        token = client.create_token(
            username: username,
            password: password)

        expect(token).to(eq(
            access_token: bearer_token,
            token_type: 'bearer',
            expires_at: expiry_date_time.iso8601,
            id_token: id_token))
      end
    end
  end
end
