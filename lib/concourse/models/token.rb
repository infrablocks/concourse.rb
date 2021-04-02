# frozen_string_literal: true

module Concourse
  module Models
    class Token
      attr_reader :access_token, :token_type, :expires_at, :id_token

      def initialize(parameters)
        @access_token = parameters[:access_token]
        @token_type = parameters[:token_type]
        @expires_at = parameters[:expires_at]
        @id_token = parameters[:id_token]
      end

      def ==(other)
        other.class == self.class && other.state == state
      end

      def eql?(other)
        self == other
      end

      def hash
        state.hash
      end

      protected

      def state
        [@access_token, @token_type, @expires_at, @id_token]
      end
    end
  end
end
