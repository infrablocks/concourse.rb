# frozen_string_literal: true

module Concourse
  module Http
    class Request
      attr_reader :url, :headers, :body

      def initialize(url, headers = {}, body = nil)
        @url = url
        @headers = headers
        @body = body
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
        [@url, @headers, @body]
      end
    end

    def assert_successful(request, response)
      raise api_error(request, response) unless response.status < 400
    end

    private

    def api_error(request, response)
      Errors::ApiError.new(request:, response:)
    end
  end
end
