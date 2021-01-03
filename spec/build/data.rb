require 'faker'
require 'openssl'
require 'jwt'
require 'date'

module Build
  module Data
    def self.random_concourse_url
      Faker::Internet.url
    end

    def self.random_cluster_name
      Faker::Lorem.words
    end

    def self.random_team_name
      Faker::Lorem.word
    end

    def self.random_email
      Faker::Internet.email
    end

    def self.random_username
      Faker::Internet.username(
          specifier: "#{Faker::Name.first_name} #{Faker::Name.last_name}")
    end

    def self.random_password
      Faker::Alphanumeric.alphanumeric(number: 40)
    end

    def self.random_digit
      Faker::Number.digit
    end

    def self.random_version
      "#{self.random_digit}.#{self.random_digit}.#{self.random_digit}"
    end

    def self.random_info(overrides = {})
      {
          version: self.random_version,
          worker_version: self.random_version,
          external_url: self.random_concourse_url,
          cluster_name: self.random_cluster_name
      }.merge(overrides)
    end

    def self.random_issuer
      Faker::Internet.url
    end

    def self.random_csrf_token
      Faker::Number.hexadecimal(digits: 64)
    end

    def self.random_subject
      Faker::Alphanumeric.alphanumeric(number: 30)
    end

    def self.random_access_token_hash
      Faker::Alphanumeric.alphanumeric(number: 22)
    end

    def self.random_bearer_token_pre_version_6_1(overrides = {}, options = {})
      one_hour_in_days = 1.0/24.0

      default_username = self.random_username
      default_csrf_token = self.random_csrf_token
      default_subject = self.random_subject
      default_email = self.random_email
      default_team_name = self.random_team_name
      default_expiration_time = (DateTime.now + one_hour_in_days)
          .to_time
          .to_i

      payload = {
          exp: default_expiration_time,
          csrf: default_csrf_token,
          sub: default_subject,
          email: default_email,
          teams: [default_team_name],
          is_admin: true,
          name: '',
          user_id: default_username,
          user_name: default_username
      }.merge(overrides)
      key = OpenSSL::PKey::RSA.generate(512)
      algorithm = options[:algorithm] || 'RS256'

      JWT.encode(payload, key, algorithm)
    end

    def self.random_bearer_token_current
      Faker::Alphanumeric.alphanumeric(number: 38)
    end

    def self.random_id_token_current(overrides = {}, options = {})
      one_hour_in_days = 1.0/24.0

      default_username = self.random_username
      default_issuer = self.random_issuer
      default_subject = self.random_subject
      default_audience = 'fly'
      default_email = self.random_email
      default_email_verified_flag = true
      default_at_hash = self.random_access_token_hash
      default_connector_id = 'local'
      default_expiration_time = (DateTime.now + one_hour_in_days)
          .to_time
          .to_i

      payload = {
          iss: default_issuer,
          sub: default_subject,
          aud: default_audience,
          exp: default_expiration_time,
          email: default_email,
          email_verified: default_email_verified_flag,
          at_hash: default_at_hash,
          federated_claims: {
              connector_id: default_connector_id,
              user_id: default_username,
              user_name: default_username
          }
      }.merge(overrides)
      key = OpenSSL::PKey::RSA.generate(512)
      algorithm = options[:algorithm] || 'RS256'

      JWT.encode(payload, key, algorithm)
    end
  end
end
