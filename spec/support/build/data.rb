# frozen_string_literal: true

require 'faker'
require 'openssl'
require 'jwt'
require 'time'

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
      Faker::Internet.username
    end

    def self.random_password
      Faker::Alphanumeric.alphanumeric(number: 40)
    end

    def self.random_digit
      Faker::Number.digit
    end

    def self.random_version
      "#{random_digit}.#{random_digit}.#{random_digit}"
    end

    def self.random_info(overrides = {})
      {
        version: random_version,
        worker_version: random_version,
        external_url: random_concourse_url,
        cluster_name: random_cluster_name
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

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Naming/VariableNumber
    def self.random_bearer_token_payload_pre_version_6_1(overrides = {})
      default_username = random_username
      {
        exp: Times.one_hour_from_now.to_i,
        csrf: random_csrf_token,
        sub: random_subject,
        email: random_email,
        teams: [random_team_name],
        is_admin: true,
        name: '',
        user_id: default_username,
        user_name: default_username
      }.merge(overrides)
    end
    # rubocop:enable Naming/VariableNumber
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Naming/VariableNumber
    def self.random_bearer_token_pre_version_6_1(overrides = {}, options = {})
      payload = random_bearer_token_payload_pre_version_6_1.merge(overrides)
      key = OpenSSL::PKey::RSA.generate(512)
      algorithm = options[:algorithm] || 'RS256'

      JWT.encode(payload, key, algorithm)
    end
    # rubocop:enable Naming/VariableNumber

    def self.random_bearer_token_current
      Faker::Alphanumeric.alphanumeric(number: 38)
    end

    # rubocop:disable Metrics/MethodLength
    def self.random_id_token_payload_current(overrides = {})
      default_username = random_username
      {
        iss: random_issuer,
        sub: random_subject,
        aud: 'fly',
        exp: Times.one_hour_from_now.to_i,
        email: random_email,
        email_verified: true,
        at_hash: random_access_token_hash,
        federated_claims: {
          connector_id: 'local',
          user_id: default_username,
          user_name: default_username
        }
      }.merge(overrides)
    end
    # rubocop:enable Metrics/MethodLength

    def self.random_id_token_current(overrides = {}, options = {})
      payload = random_id_token_payload_current(overrides)
      key = OpenSSL::PKey::RSA.generate(512)
      algorithm = options[:algorithm] || 'RS256'

      JWT.encode(payload, key, algorithm)
    end
  end
end
