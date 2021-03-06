# frozen_string_literal: true

require 'excon'
require 'json'

require 'concourse/sub_clients'

module Concourse
  class Client
    def initialize(options)
      @options = options
    end

    def for_skymarshal
      Concourse::SubClients::SkymarshalClient.new(
        @options.merge(version: get_info[:version])
      )
    end

    # rubocop:disable Naming/AccessorMethodName
    def get_info
      JSON.parse(
        Excon.get(Concourse::Urls.info_url(@options[:url]))
            .body,
        symbolize_names: true
      )
    end
    # rubocop:enable Naming/AccessorMethodName

    def ==(other)
      other.class == self.class && other.state == state
    end

    protected

    def state
      [@options]
    end
  end
end
