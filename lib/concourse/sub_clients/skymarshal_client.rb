require 'semantic'
require 'time'
require 'json'

require 'concourse/urls'
require 'concourse/headers'
require 'concourse/http'

module Concourse
  module SubClients
    class SkymarshalClient
      VERSION_6_1 = Semantic::Version.new('6.1.0')

      include Concourse::Http

      def initialize(options)
        @url = options[:url]
        @version = Semantic::Version.new(options[:version])
      end

      def create_token(parameters)
        url = create_token_url
        headers = create_token_headers
        body = create_token_body(parameters)

        token_request = Http::Request.new(url, headers, body)
        token_response = Excon.post(url, headers: headers, body: body)

        assert_successful(token_request, token_response)
        token(token_response)
      end

      def ==(other)
        other.class == self.class && other.state == state
      end

      protected

      def state
        [@options]
      end

      private

      def create_token_url
        @version >= VERSION_6_1 ?
            Concourse::Urls.sky_issuer_token_url(@url) :
            Concourse::Urls.sky_token_url(@url)
      end

      def create_token_headers
        {}
            .merge(Concourse::Headers.content_type(
                Concourse::ContentTypes::APPLICATION_WWW_FORM_URLENCODED))
            .merge(Concourse::Headers.authorization(
                Concourse::Authorization.basic(
                    "fly", "Zmx5")))
      end

      def create_token_body(parameters)
        username = parameters[:username]
        password = parameters[:password]

        scope = @version >= VERSION_6_1 ?
            'openid profile email federated:id groups' :
            'openid+profile+email+federated:id+groups'

        URI.encode_www_form({
            grant_type: 'password',
            username: username,
            password: password,
            scope: scope
        })
      end

      def token(token_response)
        token_response_date = @version >= VERSION_6_1 ?
            Time.parse(
                token_response.headers[Concourse::HeaderNames.date]) :
            nil
        token_response_body =
            JSON.parse(token_response.body, symbolize_names: true)

        @version >= VERSION_6_1 ?
            Models::Token.new(
                access_token: token_response_body[:access_token],
                token_type: token_response_body[:token_type].downcase,
                expires_at:
                    (token_response_date + token_response_body[:expires_in])
                        .iso8601,
                id_token: token_response_body[:id_token]
            ) :
            Models::Token.new(
                access_token: token_response_body[:access_token],
                token_type: token_response_body[:token_type].downcase,
                expires_at: token_response_body[:expiry],
                id_token: token_response_body[:access_token]
            )
      end
    end
  end
end