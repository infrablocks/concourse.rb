module Concourse
  module Errors
    class ApiError < StandardError
      def initialize(parameters)
        @request = parameters[:request]
        @response = parameters[:response]

        super("Request to #{@request.url} failed " +
            "with status #{@response.status} " +
            "and body #{@response.body}")
      end
    end
  end
end